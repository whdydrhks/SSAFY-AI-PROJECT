import 'dart:convert';

RegisterUser registerUserFromJson(String str) =>
    RegisterUser.fromJson(json.decode(str));

String registerUserToJson(RegisterUser data) => json.encode(data.toJson());

class RegisterUser {
  RegisterUser({
    this.userNickname,
    this.userDevice,
  });

  String? userNickname;
  String? userDevice;

  factory RegisterUser.fromJson(Map<String, dynamic> json) => RegisterUser(
        userNickname: json["userNickname"],
        userDevice: json["userDevice"],
      );

  Map<String, dynamic> toJson() => {
        "userNickname": userNickname,
        "userDevice": userDevice,
      };

  @override
  String toString() {
    // TODO: implement toString
    return "User(userNickname : $userNickname, userDevice : $userDevice)";
  }
}
