import 'dart:convert';

GetDiaryListResult getDiaryListResultFromJson(String str) =>
    GetDiaryListResult.fromJson(json.decode(str));

String getDiaryListResultToJson(GetDiaryListResult data) =>
    json.encode(data.toJson());

class GetDiaryListResult {
  GetDiaryListResult({
    this.state,
    this.result,
    this.message,
    this.data,
  });

  int? state;
  String? result;
  dynamic message;
  List<Datum>? data;

  factory GetDiaryListResult.fromJson(Map<String, dynamic> json) =>
      GetDiaryListResult(
        state: json["state"],
        result: json["result"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "state": state,
        "result": result,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    // TODO: implement toString
    return "GetDiaryListRest : (state : ${state}, result : ${result}, message : ${message}, data : ${data})";
  }
}

class Datum {
  Datum({
    this.userId,
    this.diaryId,
    this.diaryContent,
    this.diaryScore,
    this.diaryEmotion,
    this.diaryMet,
    this.diaryCreatedDate,
    this.diaryCreatedDayOfWeek,
    this.diaryModifiedDate,
    this.diaryDetailLineEmotionCount,
  });

  int? userId;
  int? diaryId;
  String? diaryContent;
  int? diaryScore;
  List<int>? diaryEmotion;
  List<int>? diaryMet;
  DateTime? diaryCreatedDate;
  String? diaryCreatedDayOfWeek;
  DateTime? diaryModifiedDate;
  List<int>? diaryDetailLineEmotionCount;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userId: json["userId"],
        diaryId: json["diaryId"],
        diaryContent: json["diaryContent"],
        diaryScore: json["diaryScore"],
        diaryEmotion: List<int>.from(json["diaryEmotion"].map((x) => x)),
        diaryMet: List<int>.from(json["diaryMet"].map((x) => x)),
        diaryCreatedDate: DateTime.parse(json["diaryCreatedDate"]),
        diaryCreatedDayOfWeek: json["diaryCreatedDayOfWeek"],
        diaryModifiedDate: DateTime.parse(json["diaryModifiedDate"]),
        diaryDetailLineEmotionCount:
            List<int>.from(json["diaryDetailLineEmotionCount"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "diaryId": diaryId,
        "diaryContent": diaryContent,
        "diaryScore": diaryScore,
        "diaryEmotion": List<dynamic>.from(diaryEmotion!.map((x) => x)),
        "diaryMet": List<dynamic>.from(diaryMet!.map((x) => x)),
        "diaryCreatedDate": diaryCreatedDate!.toIso8601String(),
        "diaryCreatedDayOfWeek": diaryCreatedDayOfWeek,
        "diaryModifiedDate": diaryModifiedDate!.toIso8601String(),
        "diaryDetailLineEmotionCount":
            List<dynamic>.from(diaryDetailLineEmotionCount!.map((x) => x)),
      };

  @override
  String toString() {
    // TODO: implement toString
    return "Datum : (userId : ${userId}, diaryId : ${diaryId}, diaryContent : ${diaryContent}, diaryScore : ${diaryScore})";
  }
}
