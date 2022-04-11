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
      List<AboutCanada> _listAboutCanada = [];
      for (int i = 0; i < responseMap['rows'].length; i++) {
        bool imagevalid =
            await validateImage(responseMap['rows'][i]['imageHref']);
        _listAboutCanada
            .add(AboutCanada.fromJson(responseMap['rows'][i], imagevalid));
      }
      return _listAboutCanada;
    } else {
      throw Exception('Error getting data');
    }
  }

  static Future<bool> validateImage(String? imageUrl) async {
    http.Response res;
    if (imageUrl == null) return false;
    try {
      res = await http.get(Uri.parse(imageUrl));
    } catch (e) {
      return false;
    }

    if (res.statusCode != 200) return false;
    Map<String, dynamic> data = res.headers;
    return checkIfImage(data['content-type']);
  }

  static bool checkIfImage(String param) {
    if (param == 'image/jpeg' || param == 'image/png' || param == 'image/gif') {
      return true;
    }
    return false;
  }
}
