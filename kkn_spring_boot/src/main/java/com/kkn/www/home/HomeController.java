package com.kkn.www.home;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/")
@CrossOrigin(origins ="*")
public class HomeController {
	@Autowired
	HomeService homeService;
	
	@PostMapping("")
	public HomeDto homeInformationLoad(@RequestBody String userid) {
		return homeService.homeInformationLoadService(userid);
	}
	
	@PostMapping("homeinformationmodify")
	public void homeInformationModify(@RequestBody HomeDto homeDto) {
		homeService.homeInformationModifiyService(homeDto);
	}
}
