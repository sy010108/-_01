package com.kkn.www.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kkn.www.repository.MemberRepository;

@Service
public class MemberLoginService {
	@Autowired
	MemberRepository memberRepository;
	
	public boolean loginService(String userid, String password) {
		if(memberRepository.countByUseridAndPassword(userid, password) == 1) {
			return true;
		}
		
		return false;
	}
}
