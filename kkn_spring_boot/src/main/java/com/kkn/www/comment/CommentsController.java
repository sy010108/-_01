package com.kkn.www.comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.kkn.www.comment.dto.CommentListAddSendDto;
import com.kkn.www.comment.dto.CommentsLoadDto;
import com.kkn.www.comment.dto.CommentsSaveDto;

@RestController
@RequestMapping("/comments")
@CrossOrigin(origins ="*")
public class CommentsController {
	@Autowired
	CommentsService commentsService;
	
	@PostMapping("/create")
	public void commentsSave(@RequestBody CommentsSaveDto newComment) {
		commentsService.commentsSaveService(newComment);
	}
	
	@PostMapping("/listadd")
	public List<CommentsLoadDto> commentListAdd(@RequestBody CommentListAddSendDto commentListAddSendDto) {
		return commentsService.commentListAddService(commentListAddSendDto);
	}
}
