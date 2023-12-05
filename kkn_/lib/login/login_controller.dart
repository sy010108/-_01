import 'dart:convert';

import '../server_connector.dart';
import 'login_input_dto.dart';

class LoginController {
  Future<String> memberLogin(LoginInputDto member) async {
    String validationErrorMessage = memberValidate(member);

    if (validationErrorMessage.isEmpty) {
      ServerConnector connector = ServerConnector();

      String body = json.encode(member.toJson());

      try {
        if (bool.parse(await connector.sendProcess("/login", body))) {
          return "";
        } else {
          return "ID 또는 비밀번호를 잘못 입력하셨습니다. 다시 입력해주세요.";
        }
      } catch (exception) {
        return connector.serverExceptionProcess(exception);
      }
    }

    return validationErrorMessage;
  }

  String memberValidate(LoginInputDto member) {
    if (member.userid.isEmpty) {
      return "ID를 입력해주세요.";
    } else if (member.password.isEmpty) {
      return "암호를 입력해주세요.";
    }

    return "";
  }
}
