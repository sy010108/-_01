class SignupDto {
  String userid;
  String nickname;
  String password;
  String email;
  String gender;
  String height;
  String weight;
  String age;

  SignupDto(this.userid, this.nickname, this.password, this.email, this.gender,
      this.height, this.weight, this.age);

  SignupDto.fromJson(Map<String, dynamic> json)
      : userid = json['userid'],
        nickname = json['nickname'],
        password = json['password'],
        email = json['email'],
        gender = json['gender'],
        height = json['height'],
        weight = json['weight'],
        age = json['age'];

  Map<String, dynamic> toJson() => {
        'userid': userid,
        'nickname': nickname,
        'password': password,
        'email': email,
        'gender': int.parse(gender),
        'height': double.parse(height),
        'weight': double.parse(weight),
        'age': int.parse(age)
      };
}
