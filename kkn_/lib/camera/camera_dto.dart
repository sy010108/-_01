class CameraDto {
  String userid;
  String calories;

  CameraDto(this.userid, this.calories);
  // json받은거 오는거 변환 spring에서 변환
  CameraDto.fromJson(Map<String, dynamic> json)
      : userid = json['userid'],
        calories = json['calories'].toString();
  // spring으로 던져줄때
  Map<String, dynamic> toJson() =>
      {'userid': userid, 'calories': double.parse(calories)};
}
