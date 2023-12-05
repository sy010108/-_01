import 'dart:convert';

import 'package:kkn_/comment/dto/comment_input_dto.dart';
import 'package:kkn_/comment/dto/comment_list_add_send_dto.dart';
import 'package:kkn_/comment/dto/comment_load_dto.dart';
import 'package:kkn_/server_connector.dart';

class CommentController {
  Future<String> commentSave(CommentInputDto commentInputDto) async {
    ServerConnector serverConnector = ServerConnector();

    if (commentInputDto.content.isNotEmpty) {
      try {
        await serverConnector.sendProcess(
            "/comments/create", json.encode(commentInputDto.toJson()));

        return "";
      } catch (exception) {
        return serverConnector.serverExceptionProcess(exception);
      }
    } else {
      return "덧글 내용을 입력해주세요.";
    }
  }

  Future<List<CommentLoadDto>> commentListAddProcess(
      CommentListAddSendDto commentListAddSendDto) async {
    ServerConnector serverConnector = ServerConnector();

    try {
      String responseBody = await serverConnector.sendProcess(
          "/comments/listadd", json.encode(commentListAddSendDto.toJson()));

      List<CommentLoadDto> addCommentList = [];
      for (dynamic addComment in json.decode(responseBody)) {
        addCommentList.add(CommentLoadDto.fromJson(addComment));
      }

      return addCommentList;
    } catch (exception) {
      serverConnector.serverExceptionProcess(exception);

      return [];
    }
  }
}
