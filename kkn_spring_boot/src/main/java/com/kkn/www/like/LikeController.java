package com.kkn.www.like;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.kkn.www.like.dto.LikeLoadSendDto;
import com.kkn.www.like.dto.LikeSaveDeleteSendDto;

@RestController
@RequestMapping("/like")
@CrossOrigin(origins ="*")
public class LikeController {
	@Autowired
	LikeService likeService;
	
	@PostMapping("")
	public List<Boolean> likeCheckListLoad(@RequestBody LikeLoadSendDto likeLoadSendDto) {
		return likeService.likeCheckListLoadService(likeLoadSendDto);
	}
	
	@PostMapping("/create")
	public void likeCheckListSave(@RequestBody LikeSaveDeleteSendDto likeSaveDeleteSendDto) {
		likeService.likeCheckListSaveService(likeSaveDeleteSendDto);
	}
	
	@PostMapping("/delete")
	public void likeCheckListDelete(@RequestBody LikeSaveDeleteSendDto likeSaveDeleteSendDto) {
		likeService.likeCheckListDeleteService(likeSaveDeleteSendDto);
	}
}
