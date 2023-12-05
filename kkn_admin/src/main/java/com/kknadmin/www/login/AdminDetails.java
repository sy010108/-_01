package com.kknadmin.www.login;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.kknadmin.www.entity.Admin;

public class AdminDetails implements UserDetails {
	private final Admin admin;
	
	public AdminDetails(Admin admin) {
		this.admin = admin;
	}
	
	public Admin getAdmin() {
		return this.admin;
	}
	
	@Override
	public String getPassword() {
		return this.admin.getPassword();
	}
	
	@Override
	public String getUsername() {
		return this.admin.getId();
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return null;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}	
}
