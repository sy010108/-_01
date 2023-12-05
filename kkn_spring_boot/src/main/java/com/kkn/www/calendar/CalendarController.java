package com.kkn.www.calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.kkn.www.calendar.dto.CalendarDayInformationLoadInputDto;
import com.kkn.www.calendar.dto.CalendarDto;

@RestController
@RequestMapping("/calendar")
@CrossOrigin(origins ="*")
public class CalendarController {
	@Autowired
	CalendarService calendarService;
	
    @PostMapping("/dayload")
    public CalendarDto dayInformationLoad(@RequestBody CalendarDayInformationLoadInputDto selectedDayInput) {    	
        return calendarService.dayInformationLoadService(selectedDayInput);
    }
}
