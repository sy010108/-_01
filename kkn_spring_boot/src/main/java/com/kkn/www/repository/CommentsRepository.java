package com.kkn.www.repository;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.kkn.www.entity.Comments;

public interface CommentsRepository extends JpaRepository<Comments, Integer>{
	List<Comments> findTop2ByPostNumOrderByCommentwritetimestampDesc(int postnum);
	List<Comments> findByPostNumAndCommentwritetimestampLessThanOrderByCommentwritetimestampDesc(int postnum, Timestamp lastCommentTimestamp);
}