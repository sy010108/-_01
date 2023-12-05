package com.kkn.www.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.kkn.www.entity.Camera;

public interface CameraRepository extends JpaRepository<Camera, Integer> {
    List<Camera> findByMemberUseridAndCameradateBetween(String userid, String cameradate, String cameradateTomorrow);
}
