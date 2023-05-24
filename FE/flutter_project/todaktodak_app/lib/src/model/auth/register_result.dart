import 'dart:convert';

RegisterResult registerResultFromJson(String str) =>
    RegisterResult.fromJson(json.decode(str));

String registerResultToJson(RegisterResult data) => json.encode(data.toJson());

class RegisterResult {
  RegisterResult({
    this.state,
    this.result,
    this.message,
    this.data,
    this.error,
  });

  int? state;
  String? result;
  String? message;
  List<dynamic>? data;
  List<dynamic>? error;

  factory RegisterResult.fromJson(Map<String, dynamic> json) => RegisterResult(
        state: json["state"],
        result: json["result"],
        message: json["message"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
        error: List<dynamic>.from(json["error"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "state": state,
        "result": result,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x)),
        "error": List<dynamic>.from(error!.map((x) => x)),
      };

  @override
  String toString() {
    return "RegisterResult : (state : $state result : $result message : $message data : $data error : $error)";
  }
}
