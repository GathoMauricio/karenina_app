import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:customers/views/customer/customer_index.dart';
import 'package:flutter/material.dart';
import 'package:customers/models/user_model.dart';
import 'package:customers/requests/user_request.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:customers/helpers/messages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:customers/views/user/user_login.dart';

class UserController {
  Messages message = Messages();
  login(UserModel userModel, context) async {
    //Se llama al FormRequest para validar el formulario
    if (UserRequest().loginRequest(userModel, context)) {
      //Iniciar loading
      message.loadingOn("Obteniendo información...", context);
      //Parémetros que se enviaran junto con la petición
      final queryParameters = {
        'email': userModel.email,
        'password': userModel.password
      };
      //Se formatea la URL
      final url = Uri.http(dotenv.env['API_URL'].toString(),
          '${dotenv.env['API_PROJECT'].toString()}/api/login', queryParameters);
      //Se envá la petición al servidor con un limitae de espra de 30 segundos
      final response =
          await http.get(url); //.timeout(const Duration(seconds: 10));
      //Se valida el estado de la respuesta
      switch (response.statusCode) {
        case 200:
          //Convirtiendo respuesta en json
          var json = jsonDecode(response.body);
          //si el estatus de la respuesta es error se muestra acontinuación
          if (json["status"] == "error") {
            message.errorMessage(json["message"], context);
          } else {
            //Si las credenciales son correctas se redirige al home de la aplicación
            initSession(json["api_token"].toString(), context);
            message.infoMessage("BIENVENIDO(A) ${json["name"]}", context);
          }
          break;
        default:
          message.errorMessage(
              "Error durante la peticion (${response.statusCode})", context);
          break;
      }
      message.loadingOf(context);
    }
  }

  initSession(String apiToken, context) async {
    //Inicializar prefs
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Guardar el api_token en las prefs
    prefs.setString('api_token', apiToken);

    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(pageBuilder: (BuildContext context,
            Animation animation, Animation secondaryAnimation) {
          return const CustomerIndex();
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }),
        (Route route) => false);
  }

  logout(context) {
    Widget cancelButton = TextButton(
      child: const Text("Cancelar"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Aceptar"),
      onPressed: () {
        closeSession(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Confirmar"),
      content: const Text("¿Realmente deseas cerrar la sesión?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  closeSession(context) async {
    //Inicializar prefs
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(pageBuilder: (BuildContext context,
            Animation animation, Animation secondaryAnimation) {
          return const UserLogin();
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }),
        (Route route) => false);
  }
}
