package com.kkn.www.community;

import com.kkn.www.entity.Community;
import com.kkn.www.entity.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommunitySaveDto {
    String userid;
    String title;
    String content;
    int likes;
    String imageurl;
    public static Community toCommunity(CommunitySaveDto communitySaveDto) {
        System.out.println("CommunitySaveDto: " + communitySaveDto);
        Community community = new Community();

        community.setTitle(communitySaveDto.getTitle());
        community.setContent(communitySaveDto.getContent());
        community.setImageurl(communitySaveDto.getImageurl());
        Member member = new Member();
        member.setUserid(communitySaveDto.getUserid());
        community.setMember(member);

        return community;
    }
}