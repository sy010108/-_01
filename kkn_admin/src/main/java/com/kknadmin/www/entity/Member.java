package com.kknadmin.www.entity;

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
	private String userid;
	
	@Column(nullable = false)
	private String nickname;
	
	@Column(nullable = false)
	private String password;
	
	@Column(nullable = false)
	private String email;
	
	@Column(nullable = false)
	private int gender;
	
	@Column(nullable = false)
	private double height;
	
	@Column(nullable = false)
	private double weight;
}
