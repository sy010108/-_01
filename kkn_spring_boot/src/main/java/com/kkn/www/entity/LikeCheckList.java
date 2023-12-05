package com.kkn.www.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name="likechecklist")
@Data
public class LikeCheckList {
	@Id
	String id;
	
	@ManyToOne
	@JoinColumn(name="userid")
	Member member;
	
	@ManyToOne
	@JoinColumn(name="postnum")
	Community community;
}
