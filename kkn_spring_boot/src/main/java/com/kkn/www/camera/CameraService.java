package com.kkn.www.camera;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kkn.www.entity.Camera;
import com.kkn.www.repository.CameraRepository;

@Service
@Transactional
public class CameraService {

    @Autowired
    CameraRepository cameraRepository;

    public String cameraService(CameraDto cameraDto) {

        List<Camera> cameraRecord = cameraRepository.findByMemberUseridAndCameradateBetween(cameraDto.getUserid(), LocalDate.now().toString(), LocalDate.now().plusDays(1).toString());

        try {
            if (!cameraRecord.isEmpty()) {
                Camera existingCamera = cameraRecord.get(0);
                existingCamera.setCalories(existingCamera.getCalories() + cameraDto.getCalories());
                // 날짜 조심....... 이게 오류가 많이남
                existingCamera.setCameradate(existingCamera.getCameradate().split(" ")[0]);
                cameraRepository.save(existingCamera);
            } else {
                Camera camera = CameraDto.toCameraConvert(cameraDto);
                camera.setCameradate(LocalDate.now().toString());
                cameraRepository.save(camera);
            }
            return "세이브성공";
        } catch (Exception e) {
            return "세이브실패";
        }
    }
}
