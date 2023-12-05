package com.kkn.www.community.dto;

import java.util.ArrayList;
import java.util.List;

import com.kkn.www.comment.dto.CommentsLoadDto;
import com.kkn.www.entity.Community;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class CommunityLoadDto {
	int num;
	String userid;
	String nickname;
	String writeDateTimeStamp;
	String title;
	String content;
	int likes;
	String imageURL;

	List<String> imageBase64List;
	List<CommentsLoadDto> commentslist;

	public CommunityLoadDto(int num, String userid, String nickname, String writeDateTimeStamp, String title, String content, int likes) {
		this.num = num;
		this.userid = userid;
		this.nickname = nickname;
		this.writeDateTimeStamp = writeDateTimeStamp;
		this.title = title;
		this.content = content;
		this.likes = likes;
	}


	public static CommunityLoadDto toCommunityHomeDto(Community community) {
		return new CommunityLoadDto(
				community.getNum(),
				community.getMember().getUserid(),
				community.getMember().getNickname(),
				community.getWritedatetime().toString(),
				community.getTitle(),
				community.getContent(),
				community.getLikes());
	}
}
