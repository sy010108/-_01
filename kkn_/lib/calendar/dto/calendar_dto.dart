class CalendarDto {
  String consumeCalories;
  String steps;
  String waterInTake;

  String distance;

  CalendarDto(
      this.consumeCalories, this.steps, this.waterInTake, this.distance);

  CalendarDto.fromJson(Map<String, dynamic> json)
      : consumeCalories = json['consumeCalories'].toString(),
        steps = json['steps'].toString(),
        waterInTake = json['waterInTake'].toString(),
        distance = (json['steps'] * 0.00075).toString();

  Map<String, dynamic> toJson() => {
        'consumeCalories': double.parse(consumeCalories),
        'steps': int.parse(steps),
        'waterInTake': double.parse(waterInTake)
      };
}
