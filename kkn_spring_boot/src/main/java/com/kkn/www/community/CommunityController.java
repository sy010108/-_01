package com.kkn.www.community;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.kkn.www.community.dto.CommunityLoadDto;
import com.kkn.www.community.dto.CommunitySaveDto;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/community")
@CrossOrigin(origins ="*")
public class CommunityController {
	@Autowired
	CommunityService communityService;

	@PostMapping("")
	public List<CommunityLoadDto> communityHomeInformationLoad(@RequestBody String loadTimestamp) {
		return communityService.communityHomeInformationLoadService(loadTimestamp);
	}
	
	@PostMapping("/listadd")
	public List<CommunityLoadDto> communityListAdd(@RequestBody String lastPostWriteTimeStamp) {
		return communityService.communityListAddService(lastPostWriteTimeStamp);
	}
	
	@PostMapping("/create")
	public void postSave(@RequestBody CommunitySaveDto communitySaveDto) {
		communityService.postSaveService(communitySaveDto);
	}
	
	@PostMapping("/delete")
	public void postDelete(@RequestBody int postNum) {
		communityService.postDeleteService(postNum);
	}

	@PostMapping("/upload")
	public String handleImageUpload(@RequestParam("images") MultipartFile[] files, @RequestParam("userid") String userid) {
		String imageUrl = communityService.handleImageUpload(files, userid);
		if (imageUrl != null) {
			return imageUrl;
		} else {
			return null;
		}
	}
}
