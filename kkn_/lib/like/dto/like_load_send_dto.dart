class LikeLoadSendDto {
  String userid;
  List<int> postNumList;

  LikeLoadSendDto(this.userid, this.postNumList);

  Map<String, dynamic> toJson() =>
      {"userid": userid, "postNumList": postNumList};
}
