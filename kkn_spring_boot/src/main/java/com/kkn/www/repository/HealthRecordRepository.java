package com.kkn.www.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.kkn.www.entity.HealthRecord;

public interface HealthRecordRepository extends JpaRepository<HealthRecord, Integer> {
	List<HealthRecord> findByMemberUseridAndHealthdateBetween(String userid, String healthdate, String healthdateTomorrow);
}
