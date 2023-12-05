package com.kkn.www.signup;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kkn.www.entity.Member;
import com.kkn.www.repository.MemberRepository;

@Service
@Transactional
public class MemberSignupService {
	@Autowired
	MemberRepository memberRepository;
	
	public boolean signupService(Member member) {
		if(!memberRepository.existsById(member.getUserid())) {
			memberRepository.save(member);
			
			return true;
		}
		
		return false;
	}
}
