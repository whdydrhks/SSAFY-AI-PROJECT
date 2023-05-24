import 'dart:convert';

GetDiaryDetailResult getDiaryDetailResultFromJson(String str) =>
    GetDiaryDetailResult.fromJson(json.decode(str));

String getDiaryDetailResultToJson(GetDiaryDetailResult data) =>
    json.encode(data.toJson());

class GetDiaryDetailResult {
  GetDiaryDetailResult({
    this.state,
    this.result,
    this.message,
    this.data,
    this.error,
  });

  int? state;
  String? result;
  dynamic message;
  Data? data;
  List<dynamic>? error;

  factory GetDiaryDetailResult.fromJson(Map<String, dynamic> json) =>
      GetDiaryDetailResult(
        state: json["state"],
        result: json["result"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        error: List<dynamic>.from(json["error"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "state": state,
        "result": result,
        "message": message,
        "data": data!.toJson(),
        "error": List<dynamic>.from(error!.map((x) => x)),
      };
}

class Data {
  Data({
    this.userId,
    this.diaryId,
    this.diaryContent,
    this.diaryScore,
    this.diaryEmotion,
    this.diaryMet,
    this.diaryDetailLineEmotionCount,
    this.diaryCreatedDayOfWeek,
    this.diaryCreatedDate,
  });

  int? userId;
  int? diaryId;
  String? diaryContent;
  int? diaryScore;
  List<int>? diaryEmotion;
  List<int>? diaryMet;
  List<int>? diaryDetailLineEmotionCount;
  String? diaryCreatedDayOfWeek;
  DateTime? diaryCreatedDate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["userId"],
        diaryId: json["diaryId"],
        diaryContent: json["diaryContent"],
        diaryScore: json["diaryScore"],
        diaryEmotion: List<int>.from(json["diaryEmotion"].map((x) => x)),
        diaryMet: List<int>.from(json["diaryMet"].map((x) => x)),
        diaryDetailLineEmotionCount:
            List<int>.from(json["diaryDetailLineEmotionCount"].map((x) => x)),
        diaryCreatedDayOfWeek: json["diaryCreatedDayOfWeek"],
        diaryCreatedDate: DateTime.parse(json["diaryCreatedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "diaryId": diaryId,
        "diaryContent": diaryContent,
        "diaryScore": diaryScore,
        "diaryEmotion": List<dynamic>.from(diaryEmotion!.map((x) => x)),
        "diaryMet": List<dynamic>.from(diaryMet!.map((x) => x)),
        "diaryDetailLineEmotionCount":
            List<dynamic>.from(diaryDetailLineEmotionCount!.map((x) => x)),
        "diaryCreatedDayOfWeek": diaryCreatedDayOfWeek,
        "diaryCreatedDate":
            "${diaryCreatedDate!.year.toString().padLeft(4, '0')}-${diaryCreatedDate!.month.toString().padLeft(2, '0')}-${diaryCreatedDate!.day.toString().padLeft(2, '0')}",
      };

  @override
  String toString() {
    // TODO: implement toString
    return "${diaryDetailLineEmotionCount}";
  }
}
