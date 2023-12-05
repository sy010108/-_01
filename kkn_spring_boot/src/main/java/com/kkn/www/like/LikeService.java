package com.kkn.www.like;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kkn.www.entity.Community;
import com.kkn.www.entity.LikeCheckList;
import com.kkn.www.like.dto.LikeLoadSendDto;
import com.kkn.www.like.dto.LikeSaveDeleteSendDto;
import com.kkn.www.repository.CommunityRepository;
import com.kkn.www.repository.LikeCheckListRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class LikeService {
	@Autowired
	LikeCheckListRepository likeCheckListRepostiory;
	
	@Autowired
	CommunityRepository communityRepository;
	
	public List<Boolean> likeCheckListLoadService(LikeLoadSendDto likeLoadSendDto) {
		List<Boolean> likeCheckedList = new ArrayList<Boolean>();
		
		for(int postNum : likeLoadSendDto.getPostNumList()) {
			likeCheckedList.add(likeCheckListRepostiory.existsByMemberUseridAndCommunityNum(likeLoadSendDto.getUserid(), postNum));
		}
		
		return likeCheckedList;
	}
	
	public void likeCheckListSaveService(LikeSaveDeleteSendDto likeSaveDeleteDto) {
		LikeCheckList newLikeCheckList = LikeSaveDeleteSendDto.toLikeCheckList(likeSaveDeleteDto);
		
		newLikeCheckList.setId(this.idGenerate());
		
		likeCheckListRepostiory.save(newLikeCheckList);
		
		this.postLikesProcess(likeSaveDeleteDto.getPostNum(), true);
	}
	
	private String idGenerate() {
		String newId = "";
		
		for(String part : LocalDate.now().toString().split("-")) {
			newId += part;
		};
		
		while(true) {
			String temp = newId.substring(2) + new Random().nextInt(10000);
			
			if(!likeCheckListRepostiory.existsById(temp)) {
				newId = temp;
				
				break;
			}
		}
		
		return newId;
	}
	
	private void postLikesProcess(int postNum, boolean isSave) {
		Community post = communityRepository.findById(postNum).get();
		
		if(isSave) {
			post.setLikes(post.getLikes() + 1);
		} else {
			post.setLikes(post.getLikes() - 1);
		}
		
		communityRepository.save(post);
	}
	
	public void likeCheckListDeleteService(LikeSaveDeleteSendDto likeSaveDeleteDto) {
		likeCheckListRepostiory.deleteByMemberUseridAndCommunityNum(likeSaveDeleteDto.getUserid(), likeSaveDeleteDto.getPostNum());
		
		this.postLikesProcess(likeSaveDeleteDto.getPostNum(), false);
	}
}
