import 'dart:convert';

import 'package:artivatic/models/about_canada.dart';
import 'package:artivatic/service/end_points.dart';
import 'package:http/http.dart' as http;

class API {
  Future<List<AboutCanada>> getCanadaDetails() async {
    http.Response response = await http.get(Uri.parse(about_canada_endpoint));

    if (response.statusCode == 200) {
      Map responseMap = jsonDecode(response.body);
      return responseMap['rows']
          .map<AboutCanada>((e) => AboutCanada.fromJson(e))
          .toList();
    } else {
      throw Exception('Error getting data');
    }
  }
}
