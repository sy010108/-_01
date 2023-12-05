package com.kkn.www.like.dto;

import java.util.List;

import lombok.Data;

@Data
public class LikeLoadSendDto {
	String userid;
	List<Integer> postNumList;
}
