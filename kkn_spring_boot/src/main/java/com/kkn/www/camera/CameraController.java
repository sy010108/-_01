package com.kkn.www.camera;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/camera")
@CrossOrigin(origins ="*")
public class CameraController {
    @Autowired
    CameraService cameraService;

    @PostMapping("/create")
    public void cameraCreate(@RequestBody CameraDto cameraDto) {
        cameraService.cameraService(cameraDto);
    }
}
