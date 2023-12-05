package com.kknadmin.www.member_management;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kknadmin.www.entity.Member;
import com.kknadmin.www.repository.MemberManagementRepository;

@Service
@Transactional
public class MemberManagementService {
	@Autowired
	private MemberManagementRepository memberRepository;
	
	public Page<MemberShowDto> membersListSearch(Pageable pageable) {
		return this.toMemberShowDtoPageConvert(memberRepository.findAll(pageable), pageable);
	}
	
	private PageImpl<MemberShowDto> toMemberShowDtoPageConvert(Page<Member> allMemberPage, Pageable pageable) {		
		return new PageImpl<MemberShowDto>(allMemberPage.getContent().stream().map(MemberShowDto::toMemberListDtoConvert).collect(Collectors.toList()), pageable, allMemberPage.getTotalElements());
	}
	
	public void pwInitialization(String userid) {
		Member member = memberRepository.findById(userid).get();
		
		member.setPassword(userid);
		
		memberRepository.save(member);
	}
	
	public void memberDelete(String userid) {
		memberRepository.deleteById(userid);
	}
	
	public Page<MemberShowDto> searchService(String category, String searchInput, Pageable pageable) {
        Page<Member> members = this.selectedMembersLoad(category, searchInput, pageable);
        
        List<MemberShowDto> memberShowDtos = members.getContent().stream()
                .map(MemberShowDto::toMemberListDtoConvert)
                .collect(Collectors.toList());
        
        return new PageImpl<>(memberShowDtos, pageable, members.getTotalElements());
    }
	
	private Page<Member> selectedMembersLoad(String category, String searchInput, Pageable pageable) {
		switch(category) {
			case "userId":
				return memberRepository.findByUseridContaining(searchInput, pageable);
	        case "nickname":
	            return memberRepository.findByNicknameContaining(searchInput, pageable);
	        default:
	        	return memberRepository.findByEmailContaining(searchInput, pageable);
		}
	}
}
