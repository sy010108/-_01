package com.kkn.www.like.dto;

import com.kkn.www.entity.Community;
import com.kkn.www.entity.LikeCheckList;
import com.kkn.www.entity.Member;

import lombok.Data;

@Data
public class LikeSaveDeleteSendDto {
	String userid;
	int postNum;
	
	public static LikeCheckList toLikeCheckList(LikeSaveDeleteSendDto likeSaveDeleteSendDto) {
		LikeCheckList likeCheckList = new LikeCheckList();
		
		Member member = new Member();
		member.setUserid(likeSaveDeleteSendDto.getUserid());
		likeCheckList.setMember(member);
		
		Community community = new Community();
		community.setNum(likeSaveDeleteSendDto.getPostNum());
		likeCheckList.setCommunity(community);
		
		return likeCheckList;
	}
}
