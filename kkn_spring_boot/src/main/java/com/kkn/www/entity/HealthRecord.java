package com.kkn.www.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name="healthrecord")
@Data
public class HealthRecord {
	@Id
	int num;
	
	String healthdate;
	
	double waterintake;
	double bmi;
	int steps;
	
	@ManyToOne
	@JoinColumn(name="userid")
	Member member;
}
