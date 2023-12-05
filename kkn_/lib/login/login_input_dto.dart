class LoginInputDto {
  String userid;
  String password;

  LoginInputDto(this.userid, this.password);

  LoginInputDto.fromJson(Map<String, dynamic> json)
      : userid = json['userid'],
        password = json['password'];

  Map<String, dynamic> toJson() => {
        'userid': userid,
        'password': password,
      };
}
