package com.kkn.www.camera;

import com.kkn.www.entity.Camera;
import com.kkn.www.entity.Member;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CameraDto {
    String userid;
    double calories;

    public static Camera toCameraConvert(CameraDto cameraDto) {
        Member member = new Member();
        Camera camera = new Camera();

        camera.setCalories(cameraDto.getCalories());
        member.setUserid(cameraDto.getUserid());
        camera.setMember(member);

        return camera;
    }
}
