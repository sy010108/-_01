package com.kkn.www.repository;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.kkn.www.entity.Community;

public interface CommunityRepository extends JpaRepository<Community, Integer>{
	List<Community> findTop10ByWritedatetimeLessThanEqualOrderByWritedatetimeDesc(Timestamp loadTimestamp);
	List<Community> findTop10ByWritedatetimeLessThanOrderByWritedatetimeDesc(Timestamp loadTimestamp);
}
