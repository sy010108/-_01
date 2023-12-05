package com.kknadmin.www.post_management.dto;

import com.kknadmin.www.entity.Comments;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommentShowDto {
	int commentNum;
	String nickname;
	String userid;
	String commentWriteTimestamp;
	String comment;
	
	public static CommentShowDto toCommentShowDto(Comments comment) {
		return new CommentShowDto(
				comment.getCommentnum(),
				comment.getMeber().getNickname(),
				comment.getMeber().getUserid(),
				comment.getCommentwritetimestamp().toString().split("\\.")[0],
				comment.getComments());
	}
}
