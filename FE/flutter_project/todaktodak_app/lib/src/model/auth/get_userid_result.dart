import 'dart:convert';

GetUserIdResult getUserIdResultFromJson(String str) =>
    GetUserIdResult.fromJson(json.decode(str));

String getUserIdResultToJson(GetUserIdResult data) =>
    json.encode(data.toJson());

class GetUserIdResult {
  GetUserIdResult({
    this.state,
    this.result,
    this.message,
    this.data,
  });

  int? state;
  String? result;
  dynamic message;
  Data? data;

  factory GetUserIdResult.fromJson(Map<String, dynamic> json) =>
      GetUserIdResult(
        state: json["state"],
        result: json["result"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "state": state,
        "result": result,
        "message": message,
        "data": data!.toJson(),
      };

  @override
  String toString() {
    // TODO: implement toString
    return "GetUserResult : (state : $state, result : $state, message : $message, data : ${data.toString()})";
  }
}

class Data {
  Data({
    this.userId,
  });

  int? userId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
      };

  @override
  String toString() {
    // TODO: implement toString
    return "Data : (userId : $userId)";
  }
}
