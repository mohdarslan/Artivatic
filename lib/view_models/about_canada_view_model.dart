import 'package:artivatic/enums.dart';
import 'package:artivatic/models/about_canada.dart';
import 'package:artivatic/service/api.dart';
import 'package:flutter/cupertino.dart';

class AboutCanadaViewModel extends ChangeNotifier {
  //making the class singleton
  AboutCanadaViewModel._privateConstructor();
  static final AboutCanadaViewModel instance =
      AboutCanadaViewModel._privateConstructor();

  late List<AboutCanada> _listAboutCanada;
  late String _title;
  LoadingStatus loadingStatus = LoadingStatus.WAITING;

  setTitle({required String title}) {
    _title = title;
  }

  Future getCanadaDetails() async {
    try {
      _listAboutCanada = await API.getCanadaDetails(setTitle: setTitle);
      loadingStatus = LoadingStatus.COMPLETED;
    } catch (e) {
      loadingStatus = LoadingStatus.ERROR;
    }
    notifyListeners();
    return;
  }

  String get title => _title;

  String? rowTitle(int index) => _listAboutCanada[index].title;
  String? rowDescription(int index) => _listAboutCanada[index].description;
  String? rowImage(int index) => _listAboutCanada[index].imageHref;

  bool isImageValid(int index) => _listAboutCanada[index].imagevalid;

  int get length => _listAboutCanada.length;
}
