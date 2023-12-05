package com.kkn.www.calendar;

import com.kkn.www.entity.HealthRecord;

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

    public static CalendarDto toCalendarDtoConvert(HealthRecord healthRecord) {
        return new CalendarDto(healthRecord.getSteps(), healthRecord.getWaterintake());
    }
}