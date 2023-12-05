package com.kknadmin.www.home;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kknadmin.www.entity.Admin;
import com.kknadmin.www.repository.AdminRepository;

@Service
public class HomeService {
	@Autowired
	AdminRepository adminRepository;
	
	public String getNameService(String id) {
		Admin admin = adminRepository.findById(id).get();
		
		return admin.getName();
	}
}
