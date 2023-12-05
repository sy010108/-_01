package com.kkn.www.community;

import com.kkn.www.comment.CommentsLoadDto;
import com.kkn.www.entity.Community;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

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