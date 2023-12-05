package com.kkn.www.community;

import lombok.Data;

@Data
public class CommunityLoadRequestDto {
    String loadTimestamp;
    int lastPage;
}