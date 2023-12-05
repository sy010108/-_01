import 'dart:convert';

import 'package:kkn_/like/dto/like_load_response_dto.dart';
import 'package:kkn_/like/dto/like_load_send_dto.dart';
import 'package:kkn_/like/dto/like_save_delete_send_dto.dart';
import 'package:kkn_/server_connector.dart';

class LikeController {
  Future<LikeLoadResponseDto> likeCheckListLoad(
      LikeLoadSendDto likeLoadSendDto) async {
    ServerConnector serverConnector = ServerConnector();

    LikeLoadResponseDto likeLoadResponseDto = LikeLoadResponseDto("", []);

    try {
      String response = await serverConnector.sendProcess(
          "/like", json.encode(likeLoadSendDto.toJson()));

      likeLoadResponseDto.likeCheckList = json.decode(response);
    } catch (exception) {
      likeLoadResponseDto.errorMessage =
          serverConnector.serverExceptionProcess(exception);
    }

    return likeLoadResponseDto;
  }

  Future<String> likeCheckListSave(
      LikeSaveDeleteSendDto likeSaveSendDto) async {
    ServerConnector serverConnector = ServerConnector();

    try {
      await serverConnector.sendProcess(
          "/like/create", json.encode(likeSaveSendDto.toJson()));

      return "";
    } catch (exception) {
      return serverConnector.serverExceptionProcess(exception);
    }
  }

  Future<String> likeCheckListDelete(
      LikeSaveDeleteSendDto likeSaveSendDto) async {
    ServerConnector serverConnector = ServerConnector();

    try {
      await serverConnector.sendProcess(
          "/like/delete", json.encode(likeSaveSendDto.toJson()));

      return "";
    } catch (exception) {
      return serverConnector.serverExceptionProcess(exception);
    }
  }
}
