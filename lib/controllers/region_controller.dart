import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:customers/models/region_model.dart';
import 'package:customers/models/commune_model.dart';
import 'package:customers/helpers/messages.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RegionController {
  Messages messages = Messages();

  Future<List<RegionModel>> index() async {
    final queryParameters = {'api_token': dotenv.env['API_TOKEN'].toString()};
    final url = Uri.http(
        dotenv.env['API_URL'].toString(),
        '${dotenv.env['API_PROJECT'].toString()}/api/index_region',
        queryParameters);
    final response = await http.get(url);
    var json = jsonDecode(response.body);
    List<RegionModel> registros = [];
    for (json in json) {
      registros
          .add(RegionModel(json['id'], json['description'], json['status']));
    }
    return registros;
  }

  Future<List<CommuneModel>> loadCommunesByRegion(idReg) async {
    final queryParameters = {
      'api_token': dotenv.env['API_TOKEN'].toString(),
      'id_reg': idReg.toString()
    };
    final url = Uri.http(
        dotenv.env['API_URL'].toString(),
        '${dotenv.env['API_PROJECT'].toString()}/api/load_communes_by_region',
        queryParameters);
    final response = await http.get(url);
    //print(response.body);
    List<CommuneModel> registros = [];
    var json = jsonDecode(response.body);
    for (json in json) {
      registros.add(CommuneModel(
          json['id'], json['id_reg'], json['description'], json['status']));
    }
    return registros;
  }
}
