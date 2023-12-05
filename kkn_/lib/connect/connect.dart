import 'package:http/http.dart' as http;

import 'package:logger/logger.dart';

class Connect {
  String appServerUrl = "http://172.29.201.185:8080";
  Map<String, String> headers = {'Content-Type': 'application/json'};

  Future<String> sendProcess(String location, String body) async {
    Logger().i(Uri.parse(appServerUrl + location));
    try {
      var response = await http.post(Uri.parse(appServerUrl + location),
          headers: headers, body: body);

      return response.body;
    } catch (e) {
      Logger().e(e);

      return "";
    }
  }
}
