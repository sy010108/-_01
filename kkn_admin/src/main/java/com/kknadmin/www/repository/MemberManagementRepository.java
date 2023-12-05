package com.kknadmin.www.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.kknadmin.www.entity.Member;

public interface MemberManagementRepository extends JpaRepository<Member, String> {
    Page<Member> findByUseridContaining(String userid, Pageable pageable);
    Page<Member> findByNicknameContaining(String nickname, Pageable pageable);
    Page<Member> findByEmailContaining(String email, Pageable pageable);
}

