package com.kknadmin.www.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.kknadmin.www.entity.Community;

public interface PostManagementRepository extends JpaRepository<Community, Integer>{
	Page<Community> findByMemberUseridContaining(String userid, Pageable pageable);
    Page<Community> findByTitleContaining(String title, Pageable pageable);
}
