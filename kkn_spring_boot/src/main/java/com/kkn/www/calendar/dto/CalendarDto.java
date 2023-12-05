package com.kkn.www.calendar.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CalendarDto {
	double consumeCalories;
	int steps;
	double waterInTake;
	
	public CalendarDto(int steps, double waterInTake) {
		this.steps = steps;
		this.waterInTake = waterInTake;
	}
}
