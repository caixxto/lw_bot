import 'package:requests/requests.dart';

class Session {
  static Map<String, String> data = {'': ''};

  Map<String, String> _getData(res) {

  RegExp exp = RegExp("id=\"authentification(.{5})\" type");
  RegExpMatch? match = exp.firstMatch(res.body);
  const start = 'authentification';
  const end = '"';
  final startIndex = match![0]!.indexOf(start);
  final endIndex = match![0]!.indexOf(end, startIndex + start.length);
  final code = match![0]!.substring(startIndex + start.length, endIndex);
  RegExp exp2 = RegExp("value=\"(.{32})\" name=");
  RegExpMatch? match2 = exp2.firstMatch(res.body);
  const start2 = 'value="';
  const end2 = '"';
  final startIndex2 = match2![0]!.indexOf(start2);
  final endIndex2 = match2![0]!.indexOf(end2, startIndex2 + start2.length);
  final code2 = match2![0]!
      .substring(startIndex2 + start2.length, endIndex2)
      .toLowerCase();
  return {code: code2};
}

  void get(url) async {
    var res = await Requests.get(url);
    res.raiseForStatus();
  }

  void post(url, body) async {
    var res = await Requests.post(url, body: {});
    res.raiseForStatus();
  }

  void req(getUrl, postUrl, login, password) async {

    var r2 = await Requests.get(getUrl);
    //r2.raiseForStatus();

    RegExp exp = RegExp("id=\"authentification(.{5})\" type");
    RegExpMatch? match = exp.firstMatch(r2.body);
    const start = 'authentification';
    const end = '"';
    final startIndex = match![0]!.indexOf(start);
    final endIndex = match![0]!.indexOf(end, startIndex + start.length);
    final code = match![0]!.substring(startIndex + start.length, endIndex);
    RegExp exp2 = RegExp("value=\"(.{32})\" name=");
    RegExpMatch? match2 = exp2.firstMatch(r2.body);
    const start2 = 'value="';
    const end2 = '"';
    final startIndex2 = match2![0]!.indexOf(start2);
    final endIndex2 = match2![0]!.indexOf(end2, startIndex2 + start2.length);
    final code2 = match2![0]!
        .substring(startIndex2 + start2.length, endIndex2)
        .toLowerCase();

    req2(code, code2, login, password, postUrl);

    // var r1 = await Requests.post(postUrl, body: {
    //   code: code2,
    //   "login": login,
    //   "password": password,
    //   'redirection': '',
    //   'isBoxStyle': ''
    // });
    //r1.raiseForStatus();

  }

  void req2(c, c2, login, password, postUrl) async {
    var r1 = await Requests.post(postUrl, body: {
      c: c2,
      "login": login,
      "password": password,
      'redirection': '',
      'isBoxStyle': ''
    });

  }

}