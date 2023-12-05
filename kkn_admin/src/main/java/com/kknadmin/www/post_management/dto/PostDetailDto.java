package com.kknadmin.www.post_management.dto;

import org.springframework.data.domain.Page;

import com.kknadmin.www.entity.Community;

import lombok.Data;

@Data
public class PostDetailDto {
	int postNum;
	String title;
	String nickname;
	String userid;
	String writeDateTime;
	String content;
	String imageUrl;
	
	Page<CommentShowDto> commentPages;
	
	public PostDetailDto(int postNum, String title, String nickname, String userid, String writeDateTime, String content, String imageUrl) {
		this.postNum = postNum;
		this.title = title;
		this.nickname = nickname;
		this.userid = userid;
		this.writeDateTime = writeDateTime;
		this.content = content;
		this.imageUrl = imageUrl;
	}
	
	public static PostDetailDto toPostDetailDto(Community community) {
		return new PostDetailDto(
				community.getNum(),
				community.getTitle(),
				community.getMember().getNickname(),
				community.getMember().getUserid(),
				community.getWritedatetime().toString().split("\\.")[0],
				community.getContent(),
				community.getImageurl());
	}
}
