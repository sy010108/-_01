import 'dart:convert';

import 'package:kkn_/mypage/dto/mypage_dto.dart';
import 'package:kkn_/mypage/dto/mypage_response_dto.dart';
import 'package:kkn_/server_connector.dart';

class MypageController {
  Future<MypageResponseDto> memberInformationLoad(String userid) async {
    ServerConnector serverConnector = ServerConnector();

    MypageResponseDto myPageResponseDto = MypageResponseDto("");

    try {
      String responseBody =
          await serverConnector.sendProcess("/mypage/load", userid);

      myPageResponseDto.mypageDto =
          MypageDto.fromJson(json.decode(responseBody));
    } catch (exception) {
      myPageResponseDto.errorMessage =
          serverConnector.serverExceptionProcess(exception);
    }

    return myPageResponseDto;
  }

  Future<String> memberupdate(MypageDto member, MypageDto rawMember) async {
    member = blankProcess(member, rawMember);

    ServerConnector connector = ServerConnector();

    String body = json.encode(member.toJson());

    try {
      await connector.sendProcess("/mypage/update", body);

      return "";
    } catch (exception) {
      return connector.serverExceptionProcess(exception);
    }
  }

  MypageDto blankProcess(MypageDto mypageDto, MypageDto rawMypageDto) {
    if (mypageDto.nickname.isEmpty) {
      mypageDto.nickname = rawMypageDto.nickname;
    }

    if (mypageDto.email.isEmpty) {
      mypageDto.email = rawMypageDto.email;
    }

    if (mypageDto.height.isEmpty) {
      mypageDto.height = rawMypageDto.height;
    }

    if (mypageDto.weight.isEmpty) {
      mypageDto.weight = rawMypageDto.weight;
    }

    if (mypageDto.age.isEmpty) {
      mypageDto.age = rawMypageDto.age;
    }

    return mypageDto;
  }
}
