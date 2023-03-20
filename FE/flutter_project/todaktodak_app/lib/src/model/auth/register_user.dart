class RegisterUser {
  String? nickname;
  String? password;
  RegisterUser({this.nickname, this.password});

  RegisterUser.fromJson(Map<String, dynamic> json)
      : nickname = json["nickname"],
        password = json["password"];

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'password': password,
      };

  @override
  String toString() {
    return "(User) nickname : $nickname, password : $password";
  }
}
