import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

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

  void login(login, password) async {
    create();

    dio.interceptors.add(CookieManager(CookieJar()));

    var firstResponse = await dio.get(
        "https://www.lowadi.com");

    RegExp exp = RegExp("id=\"authentification(.{5})\" type");
    RegExpMatch? match = exp.firstMatch(firstResponse.data);
    const start = 'authentification';
    const end = '"';
    final startIndex = match![0]!.indexOf(start);
    final endIndex = match![0]!.indexOf(end, startIndex + start.length);
    final code = match![0]!.substring(startIndex + start.length, endIndex);
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
        "https://www.lowadi.com/site/doLogIn",
        data: FormData.fromMap(
            {
              code: code2,
              'login': login,
              'password': password,
              'redirection': '',
              'isBoxStyle': ''
            }
        ));
    print(loginResponse.headers);

  }

  // void lug() async {
  //   var resp = await dio.get('https://www.lowadi.com/centre/pres');
  // }

  // void buyBox() async {
  //   var nextResponse = await dio.post(
  //       "https://www.lowadi.com/marche/achat",
  //       data: FormData.fromMap(
  //           {
  //             'id': '111',
  //             'mode': 'centre',
  //             'nombre': '1',
  //             'typeRedirection': 'box'
  //           }
  //       ));
  //   print(nextResponse.data);
  // }
  //
  Future<String> getMeadows() async {
    var response = await dio.get(
        "https://www.lowadi.com/centre/pres/");
    return response.data;
  }
  
  void collectSkin(id) async {
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
          // 'message': 'recolte',
          // 'taille': 'all',
          // 'etat': '0',
          // 'etatComparaison': 'g',
          // 'utilisation': 'all',
          // 'type': 'pres',
        }
        ));
    print(response.headers);
  }

}