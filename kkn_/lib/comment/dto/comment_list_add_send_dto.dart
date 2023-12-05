class CommentListAddSendDto {
  String postNum;
  String commentWriteTimeStamp;

  CommentListAddSendDto(this.postNum, this.commentWriteTimeStamp);

  Map<String, dynamic> toJson() => {
        "postNum": int.parse(postNum),
        "commentWriteTimeStamp": commentWriteTimeStamp
      };
}
