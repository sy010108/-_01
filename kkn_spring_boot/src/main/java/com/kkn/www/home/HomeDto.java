package com.kkn.www.home;

import com.kkn.www.entity.HealthRecord;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class HomeDto {
	String userid;
	
	String nickname;
	double consumeCalories;
	double recommandCalories;
	int steps;
	double waterInTake;
	
	public HomeDto(String userid, String nickname, double recommandCalories, int steps, double waterInTake) {
		this.userid = userid;
		this.nickname = nickname;
		this.recommandCalories = recommandCalories;
		this.steps = steps;
		this.waterInTake = waterInTake;
	}
	
	public static HomeDto toHomeDtoConvert(HealthRecord healthRecord) {
		double recommandCalories = mifflinCalculate(healthRecord.getMember().getWeight(), healthRecord.getMember().getHeight(), healthRecord.getMember().getAge());
		
		if(healthRecord.getMember().getGender() == 0) {
			recommandCalories += 5;
		} else {
			recommandCalories -= 161;
		}
		
		return new HomeDto(healthRecord.getMember().getUserid(), healthRecord.getMember().getNickname(), recommandCalories, healthRecord.getSteps(), healthRecord.getWaterintake());
	}
	
	private static double mifflinCalculate(double weight, double height, int age) {
		return 10 * weight + 6.25 * height - 5 * age;
	}
}
