package com.kknadmin.www.post_management.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kknadmin.www.post_management.PostManagementService;
import com.kknadmin.www.post_management.dto.PostDetailDto;
import com.kknadmin.www.post_management.dto.PostShowDto;

@Controller
@RequestMapping("/post")
public class PostManagementController {
	@Autowired
	PostManagementService postManagementService;
		
	@GetMapping("")
	public String allPostPrintProcess(Model model, Pageable pageable) {
		Page<PostShowDto> pages = postManagementService.postListSearch(pageable);
		
		model.addAttribute("pages", pages);
		model.addAttribute("postlist", pages.getContent());
		
		return "post_list";
	}
	
	@GetMapping("/search")
    public String searchPost(@RequestParam("category") String category, @RequestParam("searchinput") String searchInput, Pageable pageable, Model model) {
        Page<PostShowDto> pages = postManagementService.searchService(category, searchInput, pageable);
        
        model.addAttribute("category", category);
        model.addAttribute("searchInput", searchInput);
        model.addAttribute("pages", pages);
        model.addAttribute("postlist", pages.getContent());

        return "post_list";
    }
	
	@GetMapping("/detail")
	public String detailView(
			@RequestParam("postNum") int postNum,
			@RequestParam("postListPage") int postListPage,
			@RequestParam("category") String postListCategory,
			@RequestParam("searchinput") String postListSearchInput,
			Model model,
			Pageable pageable) {
		
		PostDetailDto postDetailDto = postManagementService.postDetailLoad(postNum, pageable);
		
		model.addAttribute("post", postDetailDto);
		model.addAttribute("postListPage", postListPage);
		model.addAttribute("postListCategory", postListCategory);
		model.addAttribute("postListSearchInput", postListSearchInput);
		model.addAttribute("pages", postDetailDto.getCommentPages());
		model.addAttribute("commentlist", postDetailDto.getCommentPages().getContent());
		
		return "post_detail";
	}
}
