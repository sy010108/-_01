package com.kknadmin.www.home;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {
	@Autowired
	HomeService homeService;
	
	@GetMapping("/")
	public String homeMove(HttpServletRequest request, Model model) {
		model.addAttribute("name", homeService.getNameService(this.getId(request)));
		
		return "home";
	}
	
	private String getId(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		SecurityContext securityContext = (SecurityContext)session.getAttribute("SPRING_SECURITY_CONTEXT");
		Authentication authentication = securityContext.getAuthentication();
		
		return authentication.getName();
	}
}
