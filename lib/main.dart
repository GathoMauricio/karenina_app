import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:customers/views/user/user_login.dart';
//import 'package:customers/views/user/user_login_new..dart';
import 'package:customers/views/customer/customer_index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:customers/theme/karenina_theme.dart';

Future main() async {
  //se cargan las variables de entorno
  await dotenv.load(fileName: ".env");
  //Se carga el LocalStorage
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Se valida si existe un API_TOKEN
  if (prefs.containsKey("api_token")) {
    //Se guarda en una cadena de texto
    String apiToken = prefs.getString("api_token")!;
    //Se recargan las variables de entorno añadiendo el api_token para usarlo a lo largo de la app
    await dotenv.load(fileName: ".env", mergeWith: {'API_TOKEN': apiToken});
  }
  //Se carga el tema de la app
  await KareninaTheme.initialize();
  //Al final se inicia la app
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //debugShowMaterialGrid: true,
      //showSemanticsDebugger: true,
      title: 'Flutter Demo',
      home: dotenv.env['API_TOKEN'].toString() == "null"
          ? const UserLogin() // Si el api_token no existe muestar la pantalla de login
          : const CustomerIndex(), // Si el api_token existe muestra la pantalla principal de customers
    );
  }
}
