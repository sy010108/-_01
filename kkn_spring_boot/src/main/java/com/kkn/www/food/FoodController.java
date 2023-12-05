package com.kkn.www.food;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.kkn.www.entity.Food;

@RestController
@RequestMapping("/food")
@CrossOrigin(origins ="*")
public class FoodController {
	@Autowired
    private FoodService foodService;

    @GetMapping("")
    public ResponseEntity<Food> getFoodByFoodCode(@RequestParam("foodcode") Integer foodcode) {
        Food food = foodService.getFoodByFoodCode(foodcode);
        if (food != null) {
            return ResponseEntity.ok(food);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }
}
