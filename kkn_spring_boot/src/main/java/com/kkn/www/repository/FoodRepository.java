package com.kkn.www.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.kkn.www.entity.Food;

public interface FoodRepository extends JpaRepository<Food, Integer> {
}