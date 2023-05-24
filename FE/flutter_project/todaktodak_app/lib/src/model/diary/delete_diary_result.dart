import 'dart:convert';

DeleteDiaryResult deleteDiaryResultFromJson(String str) =>
    DeleteDiaryResult.fromJson(json.decode(str));

String deleteDiaryResultToJson(DeleteDiaryResult data) =>
    json.encode(data.toJson());

class DeleteDiaryResult {
  DeleteDiaryResult({
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

  factory DeleteDiaryResult.fromJson(Map<String, dynamic> json) =>
      DeleteDiaryResult(
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
    // TODO: implement toString
    return "DeleteDiaryResult : (state : ${state}, result : ${result}, message : ${message}, data : ${data}, error : ${error})";
  }
}
