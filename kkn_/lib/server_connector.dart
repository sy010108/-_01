import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ServerConnector {
  String appServerUrl = "http://172.29.201.185:8080";
  Map<String, String> headers = {'Content-Type': 'application/json'};

  Future<String> sendProcess(String location, String body) async {
    var response = await http
        .post(Uri.parse(appServerUrl + location), headers: headers, body: body)
        .timeout(const Duration(seconds: 3));

    if (response.statusCode == 200) {
      return utf8.decode(response.bodyBytes);
    } else {
      throw Exception("server error.");
    }
  }

  String serverExceptionProcess(Object exception) {
    Logger().e(exception);

    return "서버 접속 오류. 서버 관리자에게 문의해주세요.";
  }
}
