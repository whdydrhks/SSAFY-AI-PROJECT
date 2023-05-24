import 'dart:convert';

PutDiaryUpdateResult putDiaryUpdateResultFromJson(String str) =>
    PutDiaryUpdateResult.fromJson(json.decode(str));

String putDiaryUpdateResultToJson(PutDiaryUpdateResult data) =>
    json.encode(data.toJson());

class PutDiaryUpdateResult {
  PutDiaryUpdateResult({
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

  factory PutDiaryUpdateResult.fromJson(Map<String, dynamic> json) =>
      PutDiaryUpdateResult(
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
}
