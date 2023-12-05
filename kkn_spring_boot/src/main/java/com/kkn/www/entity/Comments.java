package com.kkn.www.entity;

import java.sql.Timestamp;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name="comments")
@Data
public class Comments {
	@Id
	int commentnum;
	
	String comments;
	
	Timestamp commentwritetimestamp;
	
	@ManyToOne
	@JoinColumn(name="postnum")
	Community post;
	
	@ManyToOne
	@JoinColumn(name="userid")
	Member member;
}
