import 'dart:convert';

import 'package:artivatic/models/about_canada.dart';
import 'package:artivatic/service/end_points.dart';
import 'package:http/http.dart' as http;

class API {
  static Future<List<AboutCanada>> getCanadaDetails(
      {required Function({required String title}) setTitle}) async {
    http.Response response = await http.get(Uri.parse(about_canada_endpoint));

    if (response.statusCode == 200) {
      Map responseMap = jsonDecode(response.body);

      setTitle(title: responseMap['title']);
      return responseMap['rows']
          .map<AboutCanada>((e) => AboutCanada.fromJson(e))
          .toList();
    } else {
      throw Exception('Error getting data');
    }
  }
}
