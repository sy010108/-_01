package com.kkn.www.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@Table(name = "food")
@NoArgsConstructor
public class Food {
    @Id
    private Integer foodcode;
    private String foodname;
    private Double amount;
    private Double calorie;
    private Double protein;
    private Double fat;
    private Double carbohydrates;
}
