package com.kkn.www.comment;

import java.sql.Timestamp;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kkn.www.comment.dto.CommentListAddSendDto;
import com.kkn.www.comment.dto.CommentsLoadDto;
import com.kkn.www.comment.dto.CommentsSaveDto;
import com.kkn.www.repository.CommentsRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class CommentsService {
	@Autowired
	CommentsRepository commentRepository;
	
	public void commentsSaveService(CommentsSaveDto newComment) {
		commentRepository.save(CommentsSaveDto.toComments(newComment));
	}
	
	public List<CommentsLoadDto> commentListAddService(CommentListAddSendDto commentListAddSendDto) {
		return commentRepository.findByPostNumAndCommentwritetimestampLessThanOrderByCommentwritetimestampDesc(commentListAddSendDto.getPostNum(), Timestamp.valueOf(commentListAddSendDto.getCommentWriteTimeStamp())).stream().map(CommentsLoadDto::toCommentsDto).collect(Collectors.toList());
	}
}
