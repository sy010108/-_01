package com.kkn.www.entity;

import java.sql.Timestamp;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name="community")
@Data
public class Community {
	@Id
	int num;
	
	String title;
	String content;
	int likes;
	Timestamp writedatetime;
	String imageurl;
	@ManyToOne
	@JoinColumn(name="userid")
	Member member;
}
