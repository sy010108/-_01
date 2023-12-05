package com.kkn.www.calendar;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class CalendarDayInformationLoadInputDto {
    String userid;
    String selectedDay;
}