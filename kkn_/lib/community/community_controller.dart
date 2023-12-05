import 'dart:convert';

import 'package:kkn_/community/dto/post_save_dto.dart';
import 'package:kkn_/community/dto/post_dto.dart';
import 'package:kkn_/server_connector.dart';
import 'package:logger/logger.dart';

class CommunityController {
  Future<List<PostDto>> postListLoad(String loadTimestamp) async {
    ServerConnector serverConnector = ServerConnector();

    try {
      String responseBody =
          await serverConnector.sendProcess("/community", loadTimestamp);

      List<PostDto> postList = [];
      for (var rawPost in json.decode(responseBody)) {
        PostDto tempPostDto = PostDto.fromJson(rawPost);

        postList.add(tempPostDto);
      }

      return postList;
    } catch (exception) {
      serverConnector.serverExceptionProcess(exception);

      return [];
    }
  }

  Future<List<PostDto>> postListAdd(String lastPostWriteTimeStamp) async {
    ServerConnector serverConnector = ServerConnector();

    try {
      String responseBody = await serverConnector.sendProcess(
          "/community/listadd", lastPostWriteTimeStamp);

      List<PostDto> postList = [];
      for (var rawPost in json.decode(responseBody)) {
        PostDto tempPostDto = PostDto.fromJson(rawPost);

        postList.add(tempPostDto);
      }

      return postList;
    } catch (exeption) {
      serverConnector.serverExceptionProcess(exeption);

      return [];
    }
  }

  Future<String> postCreate(PostSaveDto communityDto) async {
    if (postFormValidate(communityDto)) {
      Logger().i(communityDto.imageurl);
      ServerConnector serverConnector = ServerConnector();

      String body = json.encode(communityDto.toJson());

      try {
        await serverConnector.sendProcess("/community/create", body);

        return "";
      } catch (exception) {
        return serverConnector.serverExceptionProcess(exception);
      }
    }

    return "빈칸을 입력해주세요.";
  }

  bool postFormValidate(PostSaveDto communityDto) {
    if (communityDto.title.isEmpty || communityDto.content.isEmpty) {
      return false;
    }
    return true;
  }

  Future<String> postDelete(
      String loginUserid, String postWriterUserid, int postNum) async {
    if (loginUserid == postWriterUserid) {
      ServerConnector serverConnector = ServerConnector();

      try {
        await serverConnector.sendProcess(
            "/community/delete", postNum.toString());

        return "";
      } catch (exception) {
        return serverConnector.serverExceptionProcess(exception);
      }
    }

    return "다른 사람이 쓴 글을 삭제할 수 없습니다.";
  }
}
