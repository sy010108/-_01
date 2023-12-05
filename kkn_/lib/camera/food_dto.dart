class FoodRequest {
  String foodcode;
  String foodname;
  String amount;
  String calorie;
  String protein;
  String fat;
  String carbohydrates;

  FoodRequest(
    this.foodcode,
    this.foodname,
    this.amount,
    this.calorie,
    this.protein,
    this.fat,
    this.carbohydrates,
  );
  // json받은거 오는거 변환 spring에서 변환
  FoodRequest.fromJson(Map<String, dynamic> json)
      : foodcode = json['foodcode'].toString(),
        foodname = json['foodname'],
        amount = json['amount'].toString(),
        calorie = json['calorie'].toString(),
        protein = json['protein'].toString(),
        fat = json['fat'].toString(),
        carbohydrates = json['carbohydrates'].toString();
  // spring으로 던져줄때
  Map<String, dynamic> toJson() => {
        'foodcode': int.parse(foodcode),
        'foodname': foodname,
        'amount': double.parse(amount),
        'calorie': double.parse(calorie),
        'protein': double.parse(protein),
        'fat': double.parse(fat),
        'carbohydrates': double.parse(carbohydrates)
      };
}
