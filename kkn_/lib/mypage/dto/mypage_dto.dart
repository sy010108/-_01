class MypageDto {
  String? userid;
  String? password;

  String nickname;
  String email;
  String gender;
  String height;
  String weight;
  String age;

  MypageDto(this.nickname, this.email, this.gender, this.height, this.weight,
      this.age);

  MypageDto.fromJson(Map<String, dynamic> json)
      : nickname = json['nickname'],
        email = json['email'],
        gender = json['gender'].toString(),
        height = json['height'].toString(),
        weight = json['weight'].toString(),
        age = json['age'].toString();

  Map<String, dynamic> toJson() => {
        'userid': userid,
        'password': password,
        'nickname': nickname,
        'email': email,
        'gender': int.parse(gender),
        'height': double.parse(height),
        'weight': double.parse(weight),
        'age': int.parse(age)
      };
}
