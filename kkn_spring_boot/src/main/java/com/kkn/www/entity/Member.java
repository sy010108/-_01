package com.kkn.www.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name="member")
@Data
public class Member {
	@Id
	String userid;
	
	@Column(nullable=false)
	String nickname;
	
	@Column(nullable=false)
	String password;
	
	@Column(nullable=false)
	String email;
	
	@Column(nullable=false)
	int gender;
	
	@Column(nullable=false)
	double height;
	
	@Column(nullable=false)
	double weight;
	
	@Column(nullable=false)
	int age;
}
