class CommentLoadDto {
  String commentnum;
  String userid;
  String comments;
  String nickname;
  String commentWriteTimeStamp;

  CommentLoadDto(this.commentnum, this.userid, this.comments, this.nickname,
      this.commentWriteTimeStamp);

  CommentLoadDto.fromJson(Map<String, dynamic> json)
      : commentnum = json['commentnum'].toString(),
        userid = json['userid'],
        comments = json['comments'],
        nickname = json['nickname'],
        commentWriteTimeStamp = json['commentWriteTimeStamp'];
}
