package com.kknadmin.www.login;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminLoginController {
	@GetMapping("/login")
	public String loginFormMove() {
		return "login";
	}
}
