package com.kknadmin.www.member_management.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kknadmin.www.member_management.MemberManagementService;

@RestController
@RequestMapping("/member")
public class MemberManagementRestController {
	@Autowired
	MemberManagementService memberManagementService;
	
	@PostMapping("/pw_initialize")
	public String pwInitializationProcess(@RequestParam("userid") String userid) {
		memberManagementService.pwInitialization(userid);
		
		return "{\"message\": \"" + userid + "의 비밀번호를 ID로 초기화 완료\"}";
	}
	
	@PostMapping("/delete")
	public String memberDeleteProcess(@RequestParam("userid") String userid) {
		this.memberManagementService.memberDelete(userid);
		
		return "{\"message\": \"" + userid + " 삭제 완료\"}";
	}
}
