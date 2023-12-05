class HomeDto {
  String userid;

  String nickname;
  String consumeCalories;
  String recommandCalories;
  String steps;
  String waterInTake;

  String distance;

  HomeDto(this.userid, this.nickname, this.consumeCalories,
      this.recommandCalories, this.steps, this.waterInTake, this.distance);

  HomeDto.fromJson(Map<String, dynamic> json)
      : userid = json['userid'],
        nickname = json['nickname'],
        consumeCalories = json['consumeCalories'].toString(),
        recommandCalories = json['recommandCalories'].toString(),
        steps = json['steps'].toString(),
        waterInTake = json['waterInTake'].toString(),
        distance = (json['steps'] * 0.00075).toString();

  Map<String, dynamic> toJson() => {
        'userid': userid,
        'nickname': nickname,
        'consumeCalories': double.parse(consumeCalories),
        'recommandCalories': double.parse(recommandCalories),
        'steps': int.parse(steps),
        'waterInTake': double.parse(waterInTake)
      };
}
