package com.kknadmin.www.post_management.dto;

import com.kknadmin.www.entity.Community;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PostShowDto {
	int postNum;
	String title;
	String nickname;
	String userid;
	String writeTimestamp;
	
	public static PostShowDto toPostShowDto(Community community) {		
		return new PostShowDto(
				community.getNum(),
				community.getTitle(),
				community.getMember().getNickname(),
				community.getMember().getUserid(),
				community.getWritedatetime().toString().split("\\.")[0]);
	}
}
