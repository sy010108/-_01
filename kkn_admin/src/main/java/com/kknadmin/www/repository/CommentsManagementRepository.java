package com.kknadmin.www.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.kknadmin.www.entity.Comments;

public interface CommentsManagementRepository extends JpaRepository<Comments, Integer>{
	Page<Comments> findByCommunityNum(int postNum, Pageable pageable);
}
