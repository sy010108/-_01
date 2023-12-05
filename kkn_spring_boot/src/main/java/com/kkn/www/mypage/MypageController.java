package com.kkn.www.mypage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.kkn.www.entity.Member;

@RestController
@RequestMapping("/mypage")
@CrossOrigin(origins ="*")
public class MypageController {
    @Autowired
    MypageService mypageService;
    
    @PostMapping("/load")
    public MyPageDto myPageInformationLoad(@RequestBody String userid) {
    	return mypageService.mypageInformationLoadService(userid);
    }

    @PostMapping("/update")
    public void mypageUpdate(@RequestBody Member member) {
        mypageService.mypageUpdateService(member);
    }
}
