package com.kknadmin.www.logout;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class AdminLogoutController {
	@GetMapping("/logout")
	public String logoutProcess(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
        
		if(session != null) {
            session.invalidate();
        }
		
		return "redirect:/login";
	}
}
