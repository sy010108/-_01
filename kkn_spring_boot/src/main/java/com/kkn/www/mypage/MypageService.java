package com.kkn.www.mypage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kkn.www.entity.Member;
import com.kkn.www.repository.MemberRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class MypageService {
    @Autowired
    MemberRepository memberRepository;
    
    public MyPageDto mypageInformationLoadService(String userid) {
    	return MyPageDto.toMyPageDto(memberRepository.findById(userid).get());
    }
    
    public void mypageUpdateService(Member member) {
    	Member oldMember = memberRepository.findById(member.getUserid()).get();
    	
    	if(member.getPassword() != null) {
    		oldMember.setPassword(member.getPassword());
    	}
        
    	oldMember.setNickname(member.getNickname());
    	oldMember.setEmail(member.getEmail());
    	oldMember.setGender(member.getGender());
    	oldMember.setHeight(member.getHeight());
        oldMember.setWeight(member.getWeight());
        oldMember.setAge(member.getAge());
        
        memberRepository.save(oldMember);
    }
}
