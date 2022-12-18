import 'dart:convert';


import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:html/parser.dart';

class Network {

  static Dio dio = Dio();

  Network._();

  static Network _instance = Network._();

  static Network get instance => _instance;

  void create() async {
    var dio = Dio(BaseOptions(
        connectTimeout: 1000,
        receiveTimeout: 1000,
        sendTimeout: 1000,
        responseType: ResponseType.json,
        followRedirects: false,
        validateStatus: (status) {
          return true;
        }
    ));
  }

  String c(response) {
    RegExp exp = RegExp("id=\"authentification(.{5})\" type");
    RegExpMatch? match = exp.firstMatch(response.data);
    const start = 'authentification';
    const end = '"';
    final startIndex = match![0]!.indexOf(start);
    final endIndex = match![0]!.indexOf(end, startIndex + start.length);
    final code = match![0]!.substring(startIndex + start.length, endIndex);
    RegExp exp2 = RegExp("value=\"(.{32})\" name=");
    RegExpMatch? match2 = exp2.firstMatch(response.data);
    const start2 = 'value="';
    const end2 = '"';
    final startIndex2 = match2![0]!.indexOf(start2);
    final endIndex2 = match2![0]!.indexOf(end2, startIndex2 + start2.length);
    final code2 = match2![0]!
        .substring(startIndex2 + start2.length, endIndex2)
        .toLowerCase();

    return code;
  }
  String c2(response) {
    RegExp exp = RegExp("id=\"authentification(.{5})\" type");
    RegExpMatch? match = exp.firstMatch(response.data);
    const start = 'authentification';
    const end = '"';
    final startIndex = match![0]!.indexOf(start);
    final endIndex = match![0]!.indexOf(end, startIndex + start.length);
    final code = match![0]!.substring(startIndex + start.length, endIndex);
    RegExp exp2 = RegExp("value=\"(.{32})\" name=");
    RegExpMatch? match2 = exp2.firstMatch(response.data);
    const start2 = 'value="';
    const end2 = '"';
    final startIndex2 = match2![0]!.indexOf(start2);
    final endIndex2 = match2![0]!.indexOf(end2, startIndex2 + start2.length);
    final code2 = match2![0]!
        .substring(startIndex2 + start2.length, endIndex2)
        .toLowerCase();

    return code2;
  }

  Future<bool> login(login, password) async {
    create();
    var ex = false;

    dio.interceptors.add(CookieManager(CookieJar()));

    var firstResponse = await dio.get(
        "https://www.lowadi.com");
    final data = firstResponse;

    await Future.delayed(const Duration(seconds: 1), () async {
      var loginResponse = await dio.post(
          "https://www.lowadi.com/site/doLogIn",
          data: FormData.fromMap(
              {
                c(data): c2(data),
                'login': login,
                'password': password,
                'redirection': '',
                'isBoxStyle': ''
              }
          ));
      ex = loginResponse.headers.toString().contains('hasLoggedIn');

    });

    return ex ? false : true;

  }

  Future<String> getMeadows() async {
    var response = await dio.get(
        "https://www.lowadi.com/centre/pres/");
    return response.data;
  }

  Future<void> collectSkin(id) async {
    var response = await dio.post(
        'https://www.lowadi.com/centre/pres/doUse',
            data:  FormData.fromMap(
        {
          'searchString': 'taille%3Dall%26etat%3D0%26etatComparaison%3Dg%26utilisation%3Dall',
          'page': '0',
          'action': 'recolter',
          'type': 'simple',
          'redirectType': 'pres',
          'id[]': '$id',
        }
        ));
    //print(response.headers);
  }

  Future<void> sellSkin() async {
    var response = await dio.post(
        'https://www.lowadi.com/marche/vente',
        data:  FormData.fromMap(
            {
              'id': '456',
              'nombre': '10000',
              'mode': 'eleveur',
            }
        ));
  }

  Future<String> checkEquus() async {
    var response = await dio.get(
        'https://www.lowadi.com/centre/pres/');
    final document = parse(response.data);

    return response.data;
  }

  Future<String> getData() async { //get all data from market page
    var response = await dio.get(
        'https://www.lowadi.com/marche/boutique');
    //final document = parse(response.data);

    return response.data;
  }

  Future<void> setSkin(id) async {
    var response = await dio.post(
        'https://www.lowadi.com/centre/pres/doUse',
        data:  FormData.fromMap(
            {
              'id[]': '$id',
              'action': 'putInCulture',
              'page': '0',
              'searchString': 'taille=all&etat=0&etatComparaison=g&utilisation=all',
              'type': 'simple',
              'recette': '10',
              'recette': '10',
              'redirectType': 'pres',
              'engrais': 'none',
            }
        ));
    //print(response.headers);
  }


  Future<void> logOut() async {

    var firstResponse = await dio.get(
        "https://www.lowadi.com");

    RegExp exp2 = RegExp("value=\"(.{32})\" name=");
    RegExpMatch? match2 = exp2.firstMatch(firstResponse.data);
    const start2 = 'value="';
    const end2 = '"';
    final startIndex2 = match2![0]!.indexOf(start2);
    final endIndex2 = match2![0]!.indexOf(end2, startIndex2 + start2.length);
    final code2 = match2![0]!
        .substring(startIndex2 + start2.length, endIndex2)
        .toLowerCase();

    var loginResponse = await dio.post(
        "https://www.lowadi.com/site/doLogOut",
        data: FormData.fromMap(
            {
              'sid': '$code2',
            }
        ));
    print('Log Out');

    //dio.interceptors.clear();

  }

}