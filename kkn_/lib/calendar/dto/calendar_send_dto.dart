class CalendarSendDto {
  String userid;
  String selectedDay;

  CalendarSendDto(this.userid, this.selectedDay);

  Map<String, dynamic> toJson() => {
        'userid': userid,
        'selectedDay': selectedDay,
      };
}
