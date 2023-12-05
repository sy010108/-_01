import 'package:kkn_/comment/dto/comment_load_dto.dart';

class PostDto {
  String num;
  String userid;
  String nickname;
  String writeDateTimeStamp;

  String title;
  String content;
  int likes;

  List<CommentLoadDto>? commentList; // 댓글 목록
  List<String>? imageBase64List; // 이미지 Base64 인코딩 목록

  PostDto({
    required this.num,
    required this.userid,
    required this.nickname,
    required this.writeDateTimeStamp,
    required this.title,
    required this.content,
    this.imageBase64List,
  }) : likes = 0;

  PostDto.fromJson(Map<String, dynamic> json)
      : num = json['num'].toString(),
        userid = json["userid"],
        nickname = json["nickname"],
        writeDateTimeStamp = json["writeDateTimeStamp"],
        title = json['title'],
        content = json['content'],
        likes = json['likes'] {
    if (json['commentslist'] != null) {
      commentList = toCommentLoadDtoProcess(json['commentslist']);
    }

    if (json['imageBase64List'] != null) {
      imageBase64List = List<String>.from(json['imageBase64List']);
    }
  }

  List<CommentLoadDto> toCommentLoadDtoProcess(List<dynamic> rawCommentList) {
    List<CommentLoadDto> commentList = [];

    for (var comment in rawCommentList) {
      commentList.add(CommentLoadDto.fromJson(comment));
    }

    return commentList;
  }
}
