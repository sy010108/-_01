package com.kkn.www.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.kkn.www.entity.Member;

public interface MemberRepository extends JpaRepository<Member, String>{
	int countByUseridAndPassword(String userid, String password);
}
