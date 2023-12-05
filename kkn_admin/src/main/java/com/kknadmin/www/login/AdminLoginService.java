package com.kknadmin.www.login;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.kknadmin.www.entity.Admin;
import com.kknadmin.www.repository.AdminRepository;

@Service
public class AdminLoginService implements UserDetailsService{
	@Autowired
	private AdminRepository adminRepository;
	
	@Override
	public UserDetails loadUserByUsername(String id) throws UsernameNotFoundException {
		Optional<Admin> userOp = adminRepository.findById(id);
		
		return userOp.map(user -> new AdminDetails(user)).orElseThrow(() -> new UsernameNotFoundException("등록하지 않은 ID를 입력하거나 ID 또는 암호를 잘못 입력함"));
	}
}
