class LikeSaveDeleteSendDto {
  String userid;
  String postNum;

  LikeSaveDeleteSendDto(this.userid, this.postNum);

  Map<String, dynamic> toJson() =>
      {"userid": userid, "postNum": int.parse(postNum)};
}
