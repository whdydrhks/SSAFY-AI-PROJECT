import 'dart:convert';

ValidateNicknameResult validateNicknameResultFromJson(String str) =>
    ValidateNicknameResult.fromJson(json.decode(str));

String validateNicknameResultToJson(ValidateNicknameResult data) =>
    json.encode(data.toJson());

class ValidateNicknameResult {
  ValidateNicknameResult({
    this.state,
    this.result,
    this.message,
  });

  int? state;
  String? result;
  dynamic message;

  factory ValidateNicknameResult.fromJson(Map<String, dynamic> json) =>
      ValidateNicknameResult(
        state: json["state"],
        result: json["result"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "state": state,
        "result": result,
        "message": message,
      };

  @override
  String toString() {
    // TODO: implement toString
    return "Validate Result state : ${state}, result : ${result}, message : ${message}";
  }
}
