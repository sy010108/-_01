package com.kkn.www.calendar.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class CalendarDayInformationLoadInputDto {
	String userid;
	String selectedDay;
}
