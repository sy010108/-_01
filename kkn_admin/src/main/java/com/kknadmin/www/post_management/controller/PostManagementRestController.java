package com.kknadmin.www.post_management.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kknadmin.www.post_management.PostManagementService;

@RestController
@RequestMapping("/post")
public class PostManagementRestController {
	@Autowired
	PostManagementService postManagementService;
	
	@PostMapping("/delete")
	public String memberDeleteProcess(@RequestParam("postNum") int postNum) {
		this.postManagementService.postDelete(postNum);
		
		return "{\"message\": \"글 삭제 완료\"}";
	}
	
	@PostMapping("/commentdelete")
	public String commentDeleteProcess(@RequestParam("commentNum") int commentNum) {
		this.postManagementService.commentDelete(commentNum);
		
		return "{\"message\": \"덧글 삭제 완료\"}";
	}
}
