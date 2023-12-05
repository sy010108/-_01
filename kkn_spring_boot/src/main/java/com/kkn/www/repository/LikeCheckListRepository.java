package com.kkn.www.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.kkn.www.entity.LikeCheckList;

public interface LikeCheckListRepository extends JpaRepository<LikeCheckList, String>{
	boolean existsByMemberUseridAndCommunityNum(String userid, int postNum);
	String deleteByMemberUseridAndCommunityNum(String userid, int postNum);
}
