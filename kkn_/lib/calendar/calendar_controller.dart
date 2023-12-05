import 'dart:convert';

import 'package:kkn_/calendar/dto/calendar_dto.dart';
import 'package:kkn_/calendar/dto/calendar_response_dto.dart';
import 'package:kkn_/calendar/dto/calendar_send_dto.dart';
import 'package:kkn_/server_connector.dart';

class CalendarController {
  Future<CalendarResponseDto> selectedDayInformationLoad(
      CalendarSendDto calendarSendDto) async {
    CalendarResponseDto selectedDayCalendarResponseDto =
        CalendarResponseDto("");

    ServerConnector connector = ServerConnector();

    String body = json.encode(calendarSendDto.toJson());

    try {
      String response = await connector.sendProcess("/calendar/dayload", body);
      selectedDayCalendarResponseDto.calendarDto =
          CalendarDto.fromJson(json.decode(response));
    } catch (exception) {
      selectedDayCalendarResponseDto.errorMessage =
          connector.serverExceptionProcess(exception);
    }

    return selectedDayCalendarResponseDto;
  }
}
