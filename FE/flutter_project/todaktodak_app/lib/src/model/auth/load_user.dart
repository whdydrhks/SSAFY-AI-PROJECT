import 'dart:convert';

LoadUser loadUserFromJson(String str) => LoadUser.fromJson(json.decode(str));

String loadUserToJson(LoadUser data) => json.encode(data.toJson());

class LoadUser {
  LoadUser({
    this.userNickname,
    this.userDevice,
  });

  String? userNickname;
  String? userDevice;

  factory LoadUser.fromJson(Map<String, dynamic> json) => LoadUser(
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
    return "User(userNickname : ${userNickname}, userDevice : ${userDevice})";
  }
}
