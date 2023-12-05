package com.kkn.www.comment;

import com.kkn.www.entity.Comments;
import com.kkn.www.entity.Community;
import com.kkn.www.entity.Member;
import lombok.Data;

import java.sql.Timestamp;
import java.time.LocalDateTime;

@Data
public class CommentsSaveDto {
    int postNum;
    String userid;
    String content;

    public static Comments toComments(CommentsSaveDto commentSaveDto) {
        Comments comments = new Comments();

        comments.setComments(commentSaveDto.getContent());
        comments.setCommentwritetimestamp(Timestamp.valueOf(LocalDateTime.now()));

        Member member = new Member();
        member.setUserid(commentSaveDto.getUserid());
        comments.setMember(member);

        Community community = new Community();
        community.setNum(commentSaveDto.getPostNum());
        comments.setPost(community);

        return comments;
    }
}