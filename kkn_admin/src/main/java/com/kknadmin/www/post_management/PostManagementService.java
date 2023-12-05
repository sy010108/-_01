package com.kknadmin.www.post_management;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.kknadmin.www.entity.Comments;
import com.kknadmin.www.entity.Community;
import com.kknadmin.www.post_management.dto.CommentShowDto;
import com.kknadmin.www.post_management.dto.PostDetailDto;
import com.kknadmin.www.post_management.dto.PostShowDto;
import com.kknadmin.www.repository.CommentsManagementRepository;
import com.kknadmin.www.repository.PostManagementRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class PostManagementService {
	@Autowired
	private PostManagementRepository postManagementRepository;
	
	@Autowired
	private CommentsManagementRepository commentsManagementRepository;
	
	public Page<PostShowDto> postListSearch(Pageable pageable) {
		return this.toPostShowDtoPageConvert(postManagementRepository.findAll(pageable), pageable);
	}
	
	private PageImpl<PostShowDto> toPostShowDtoPageConvert(Page<Community> allMemberPage, Pageable pageable) {		
		return new PageImpl<PostShowDto>(allMemberPage.getContent().stream().map(PostShowDto::toPostShowDto).collect(Collectors.toList()), pageable, allMemberPage.getTotalElements());
	}
	
	public Page<PostShowDto> searchService(String category, String searchInput, Pageable pageable) {
        Page<Community> posts = this.selectedPostLoad(category, searchInput, pageable);
        
        List<PostShowDto> postShowDtos = posts.getContent().stream()
                .map(PostShowDto::toPostShowDto)
                .collect(Collectors.toList());
        
        return new PageImpl<>(postShowDtos, pageable, posts.getTotalElements());
    }
	
	private Page<Community> selectedPostLoad(String category, String searchInput, Pageable pageable) {
		switch(category) {
			case "userId":
				return postManagementRepository.findByMemberUseridContaining(searchInput, pageable);
	        default:
	            return postManagementRepository.findByTitleContaining(searchInput, pageable);
		}
	}
	
	public PostDetailDto postDetailLoad(int postNum, Pageable pageable) {
		PostDetailDto postDetailDto = PostDetailDto.toPostDetailDto(postManagementRepository.findById(postNum).get());
		
		postDetailDto.setCommentPages(this.toCommentShowDtoPageConvert(commentsManagementRepository.findByCommunityNum(postNum, pageable), pageable));
		
		return postDetailDto;
	}
	
	private PageImpl<CommentShowDto> toCommentShowDtoPageConvert(Page<Comments> commentShowDto, Pageable pageable) {
		return new PageImpl<CommentShowDto>(commentShowDto
				.getContent()
				.stream()
				.map(CommentShowDto::toCommentShowDto)
				.collect(Collectors.toList()), pageable, commentShowDto.getTotalElements());
	}
	
	public void postDelete(int postNum) {
		postManagementRepository.deleteById(postNum);
	}
	
	public void commentDelete(int commentNum) {
		commentsManagementRepository.deleteById(commentNum);
	}
}
