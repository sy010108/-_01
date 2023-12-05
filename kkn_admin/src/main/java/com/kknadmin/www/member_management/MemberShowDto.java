package com.kknadmin.www.member_management;

import com.kknadmin.www.entity.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberShowDto {
	private String userid;
	private String nickname;
	private String email;
	
	public static MemberShowDto toMemberListDtoConvert(Member member) {
		return new MemberShowDto(member.getUserid(), member.getEmail(), member.getNickname());
	}
}
