package com.kkn.www.calendar;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kkn.www.calendar.dto.CalendarDayInformationLoadInputDto;
import com.kkn.www.calendar.dto.CalendarDto;
import com.kkn.www.entity.Camera;
import com.kkn.www.entity.HealthRecord;
import com.kkn.www.repository.CameraRepository;
import com.kkn.www.repository.HealthRecordRepository;

@Service
public class CalendarService {
    @Autowired
    HealthRecordRepository healthRecordRepository;
    
    @Autowired
    CameraRepository cameraRepostiory;

    public CalendarDto dayInformationLoadService(CalendarDayInformationLoadInputDto selectedDayInput) {
    	CalendarDto seletedDayCalendarDto = this.selectedDayInCalendarListSearch(healthRecordRepository.findByMemberUseridAndHealthdateBetween(selectedDayInput.getUserid(), selectedDayInput.getSelectedDay(), LocalDate.parse(selectedDayInput.getSelectedDay()).plusDays(1).toString()), selectedDayInput.getSelectedDay());
    	
    	seletedDayCalendarDto = this.selectedDayInCameraListSearch(cameraRepostiory.findByMemberUseridAndCameradateBetween(selectedDayInput.getUserid(), selectedDayInput.getSelectedDay(), LocalDate.parse(selectedDayInput.getSelectedDay()).plusDays(1).toString()), selectedDayInput.getSelectedDay(), seletedDayCalendarDto);
    	
    	return seletedDayCalendarDto;
    }
    
    private CalendarDto selectedDayInCalendarListSearch(List<HealthRecord> healthRecordList, String selectedDay) {
    	CalendarDto calendarDto = new CalendarDto(0, 0, 0);
    	
    	for(HealthRecord healthRecord : healthRecordList) {
    		if(healthRecord.getHealthdate().split(" ")[0].equals(selectedDay)) {
    			calendarDto.setSteps(healthRecord.getSteps());
    			calendarDto.setWaterInTake(healthRecord.getWaterintake());
    		}
    	}
    	
    	return calendarDto;
    }
    
    private CalendarDto selectedDayInCameraListSearch(List<Camera> cameraList, String selectedDay, CalendarDto seletedDayCalendarDto) {
    	for(Camera camera : cameraList) {
    		if(camera.getCameradate().split(" ")[0].equals(selectedDay)) {
    			seletedDayCalendarDto.setConsumeCalories(camera.getCalories());
    		}
    	}
    	
    	return seletedDayCalendarDto;
    }
}