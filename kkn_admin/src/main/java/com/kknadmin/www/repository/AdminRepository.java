package com.kknadmin.www.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.kknadmin.www.entity.Admin;

public interface AdminRepository extends JpaRepository<Admin, String>{
}
