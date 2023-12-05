package com.kkn.www.mypage;

import com.kkn.www.entity.Member;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class MyPageDto {
	String nickname;
	String email;
	int gender;
	double height;
	double weight;
	int age;
	
	public static MyPageDto toMyPageDto(Member member) {
		return new MyPageDto(
				member.getNickname(),
				member.getEmail(),
				member.getGender(),
				member.getHeight(),
				member.getWeight(),
				member.getAge());
	}
}
