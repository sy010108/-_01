package com.kknadmin.www.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.savedrequest.NullRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {
	@Bean
	SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
		RequestCache nullRequestCache = new NullRequestCache();
		
		http.formLogin(login -> login
				.loginPage("/login")
				.defaultSuccessUrl("/")
				.permitAll()
		).authorizeHttpRequests(authz -> authz
				.requestMatchers("/login", "/css/**", "/images/**")
				.permitAll()
				.anyRequest()
				.authenticated()
		).requestCache(cache -> cache
				.requestCache(nullRequestCache)
		);

		return http.build();
	}
	
	@Bean
	PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
}
