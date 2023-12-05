class CommentInputDto {
  String postNum;
  String userid;
  String content;

  CommentInputDto(this.postNum, this.userid, this.content);

  Map<String, dynamic> toJson() => {
        'postNum': int.parse(postNum),
        'userid': userid,
        'content': content,
      };
}
