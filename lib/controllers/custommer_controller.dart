import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:customers/models/customer_model.dart';
import 'package:customers/helpers/messages.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CustomerController {
  Messages messages = Messages();
  Future<List<CustomerModel>> index(context) async {
    //Parémetros que se enviaran junto con la petición
    final queryParameters = {'api_token': dotenv.env['API_TOKEN'].toString()};
    //Se formatea la URL
    final url = Uri.http(
        dotenv.env['API_URL'].toString(),
        '${dotenv.env['API_PROJECT'].toString()}/api/index_customer',
        queryParameters);
    //Se envá la petición al servidor con un limitae de espra de 30 segundos
    final response =
        await http.get(url); //.timeout(const Duration(seconds: 90));
    //Codificar datos en json
    var json = jsonDecode(response.body);
    //lista de registros
    List<CustomerModel> registros = [];
    //Guardar json en la lista que se va a retornar
    for (json in json) {
      registros.add(CustomerModel(json['id_reg'], json['id_com'], json['dni'],
          json['email'], json['name'], json['last_name'], json['address']));
    }
    //retorna el resultado
    return registros;
  }
}
