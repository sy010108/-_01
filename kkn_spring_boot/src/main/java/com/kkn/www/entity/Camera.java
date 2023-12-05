package com.kkn.www.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
@Table(name="camera")
public class Camera {

    @Id
    int num;

    String cameradate;
    double calories;

    @ManyToOne
    @JoinColumn(name="userid")
    Member member;

}
