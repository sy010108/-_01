package com.kknadmin.www.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name="admin")
@Data
public class Admin {
	@Id
	private String id;
	
	@Column(nullable = false)
	private String password;
	
	private String name;
	
	private String email;
}
