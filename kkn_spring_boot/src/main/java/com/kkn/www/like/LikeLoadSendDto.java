package com.kkn.www.like;

import lombok.Data;

import java.util.List;

@Data
public class LikeLoadSendDto {
    String userid;
    List<Integer> postNumList;
}