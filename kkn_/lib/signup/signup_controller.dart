import 'dart:convert';
import 'package:kkn_/signup/signup_dto.dart';

import '../server_connector.dart';

class SignupController {
  Future<String> memberSignup(SignupDto newMember) async {
    String validationErrorMessage = newMemberValidate(newMember);

    if (validationErrorMessage.isEmpty) {
      ServerConnector connector = ServerConnector();

      String body = json.encode(newMember.toJson());

      try {
        if (bool.parse(await connector.sendProcess("/signup", body))) {
          return "";
        } else {
          return "입력한 ID는 이미 회원등록된 ID입니다. 다른 ID를 입력해주세요.";
        }
      } catch (exception) {
        return connector.serverExceptionProcess(exception);
      }
    }

    return validationErrorMessage;
  }

  String newMemberValidate(SignupDto newMember) {
    if (newMember.userid.isEmpty) {
      return "ID를 입력해주세요.";
    } else if (newMember.password.isEmpty) {
      return "암호를 입력해주세요.";
    } else if (newMember.nickname.isEmpty) {
      return "닉네임를 입력해주세요.";
    } else if (newMember.email.isEmpty) {
      return "이메일를 입력해주세요.";
    } else if (newMember.age.isEmpty) {
      return "나이를 입력해주세요.";
    } else if (newMember.height.isEmpty) {
      return "키를 입력해주세요.";
    } else if (newMember.weight.isEmpty) {
      return "체중을 입력해주세요.";
    }

    return "";
  }
}
