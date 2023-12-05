package com.kkn.www.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.kkn.www.entity.Member;

@RestController
@CrossOrigin(origins ="*")
public class MemberLoginController {
	@Autowired
	MemberLoginService memberService;
	
	@PostMapping("/login")
	public boolean loginController(@RequestBody Member member) {
		return memberService.loginService(member.getUserid(), member.getPassword());
	}
}
