package com.kkn.www.signup;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.kkn.www.entity.Member;

@RestController
@CrossOrigin(origins ="*")
public class MemberSignupController {
	@Autowired
	MemberSignupService memberSignupService;
	
	@PostMapping("/signup")
	public boolean signupController(@RequestBody Member member) {
		return memberSignupService.signupService(member);
	}
}
