package com.kkn.www.comment.dto;

import com.kkn.www.entity.Comments;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommentsLoadDto {
	int commentnum;
	String userid;
	
	String comments;
	String nickname;
	
	String commentWriteTimeStamp;
	
	public static CommentsLoadDto toCommentsDto(Comments comments) {
		return new CommentsLoadDto(
				comments.getCommentnum(),
				comments.getMember().getUserid(),
				comments.getComments(),
				comments.getMember().getNickname(),
				comments.getCommentwritetimestamp().toString());
	}
}
