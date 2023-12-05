package com.kkn.www.food;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kkn.www.entity.Food;
import com.kkn.www.repository.FoodRepository;

@Service
public class FoodService {
	@Autowired
	private FoodRepository foodRepository;

    public Food getFoodByFoodCode(Integer foodcode) {
        return foodRepository.findById(foodcode).orElse(null);
    }
}
