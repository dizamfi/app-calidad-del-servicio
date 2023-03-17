import 'dart:async';
import 'package:calidad_del_servicio/services/servicio_notificacion_push.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:postgres/postgres.dart';

class ServicioPostgrest {
  static PostgreSQLConnection? connection;

  // Conexión a la base de datos
  static inializatePostgres() async {
    connection = PostgreSQLConnection("200.10.150.149", 5432, "calidad_red",
        username: "postgres", password: "h8bmbfar");
    await connection!.open().then((value) {
      debugPrint("Database Connected!");
    });
  }

  // Insertar registros en la tabla user_data
  static Future insertRegistro(Map<String, String> formValues) async {
    await connection!.mappedResultsQuery(
        "INSERT INTO user_data(usuarionombre,usuarioapellido,mail,telefono,user_dni,user_password) VALUES(@nombre, @apellido, @correo, @telf, @dni, @pass);",
        substitutionValues: {
          "nombre": formValues['nombre'],
          "apellido": formValues['apellido'],
          "correo": formValues['correo'],
          "telf": formValues['telefono'],
          "dni": formValues['cedula'],
          "pass": formValues['contraseña'],
        });
  }

  static Future updateDevice(String token, String dni) async {
    // Query para actualizar la tabla device
    await connection!.query(
        "UPDATE device SET device_token = @token WHERE user_dni = @dni;",
        substitutionValues: {"token": token, "dni": dni});
  }

  // Seleccionar los campos mail y user_dni de la tabla user_data
  static Future<List<Map<String, Map<String, dynamic>>>> selectUser() async {
    List<Map<String, Map<String, dynamic>>> result = await connection!
        .mappedResultsQuery("SELECT mail,user_dni FROM user_data");

    return result;
  }

  // Selecciona todos los campos de la tabla user_data donde sean iguales la contraseña y la cédula
  // pasadas en formValues

  // ignore: non_constant_identifier_names
  static Future<List<Map<String, Map<String, dynamic>>>> query_user_pass(
      Map<String, String> formValues) async {
    List<
        Map<
            String,
            Map<String,
                dynamic>>> result = await connection!.mappedResultsQuery(
        "select * from user_data where (user_dni LIKE @user_dni AND user_password LIKE @user_password);",
        substitutionValues: {
          "user_dni": formValues['cedula'],
          "user_password": formValues['contrasena'],
          //"correo": formValues['correo'],
        });

    return result;
  }

  static Future<List<Map<String, Map<String, dynamic>>>>
      query_device_registered(String macAddress) async {
    List<Map<String, Map<String, dynamic>>> result = await connection!
        .mappedResultsQuery(
            "select * from device where (device_mac LIKE @device_mac);",
            substitutionValues: {
          "device_mac": macAddress,
        });

    return result;
  }

  static void queryInicioSesion(
      String macAddress, String ip, Map<String, String> formValues) async {
    List<Map<String, Map<String, dynamic>>> queryDeviceRegistered =
        await ServicioPostgrest.connection!.mappedResultsQuery(
            "select * from device where (device_mac LIKE @device_mac);",
            substitutionValues: {
          "device_mac": macAddress,
        });

    //Verifica si el dispositivo se encuentra registrado por medio de su MAC en la tabla device
    if (queryDeviceRegistered.isEmpty) {
      //Si el dispositivo no esta registrado, lo ingresa en la tabla device que a la vez crea un registro en la tabla sesion (???)
      await connection!.mappedResultsQuery(
          "INSERT INTO device(user_dni,device_token,device_mac,device_ip) VALUES(@user_dni,@sesion_token,@device_mac,@device_ip);",
          substitutionValues: {
            "user_dni": formValues['cedula'],
            "sesion_token": ServicioNotificacionPush.token,
            "device_mac": macAddress,
            "device_ip": ip
          });
    } else {
      //En el caso de que si este registrado,lo empata con el registro de usuario por medio del user_dni
      await connection!.mappedResultsQuery(
          "UPDATE device SET user_dni=@userdni,device_token=@sesion_token where(device_mac=@mac)",
          substitutionValues: {
            "userdni": formValues['cedula'],
            "sesion_token": ServicioNotificacionPush.token,
            "mac": macAddress,
          });
      debugPrint("UPDATE");
    }
    List<Map<String, Map<String, dynamic>>>
        queryConsultaRegistroAnteriorDeFecha =
        await connection!.mappedResultsQuery(
            "select * from sesion where (sesion_token like @sesion_token AND extract (day from sesion_fecha)=@dia_actual)",
            substitutionValues: {
          "sesion_token": ServicioNotificacionPush.token,
          "dia_actual": DateTime.now().day,
        });
    //Verificamos en la tabla sesion si existe un registro anterior para el dispositivo por token y fecha actual.
    if (queryConsultaRegistroAnteriorDeFecha.isEmpty) {
      //En el caso de que no exista lo crea.(Registro de sesion)
      await connection!.mappedResultsQuery(
          "INSERT INTO sesion(sesion_token,sesion_fecha,estado_sesion) VALUES(@sesion_token,@sesion_fecha,1);",
          substitutionValues: {
            "sesion_token": ServicioNotificacionPush.token,
            "sesion_fecha": DateTime.now(),
          });
      debugPrint("INSERT");
    }
  }

  static Future<int> verificarSesion() async {
    //En el caso de que si exista verificamos el estado.(Esto en caso de que cierre la app y vuelva a iniciar sesion)(Sesion activa o no)
    List<Map<String, Map<String, dynamic>>> queryConsultaEstado =
        await connection!.mappedResultsQuery(
            "select estado_sesion from sesion where (sesion_token LIKE @sesion_token AND extract (day from sesion_fecha)=@dia_actual);",
            substitutionValues: {
          "sesion_token": ServicioNotificacionPush.token,
          "dia_actual": DateTime.now().day,
        });

    if (queryConsultaEstado.isEmpty) {
      return -1;
    }

    if (queryConsultaEstado[0]['sesion']!['estado_sesion'] == 1) {
      debugPrint('EL DIPOSITIVO TIENE UNA SESION ACTIVA, PUEDE NAVEGAR');
      return 1;
    } else {
      debugPrint('EL DISPOSITIVO NO TIENE UNA SESION ACTIVA, NO PUEDE NAVEGAR');
      return 0;
      //DESDE EL BACKEND MODIFICAR EL estado_sesion al momento de dar o quitar la navegacion
    }
  }
}
