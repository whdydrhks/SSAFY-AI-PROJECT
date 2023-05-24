import 'dart:convert';

List<UserDiaryList> userDiaryListFromJson(String str) =>
    List<UserDiaryList>.from(
        json.decode(str).map((x) => UserDiaryList.fromJson(x)));

String userDiaryListToJson(List<UserDiaryList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserDiaryList {
  UserDiaryList({
    this.diaryId,
    this.diaryContent,
    this.diaryScore,
    this.emotions,
    this.mets,
  });

  int? diaryId;
  String? diaryContent;
  int? diaryScore;
  List<Emotion>? emotions;
  List<Met>? mets;

  factory UserDiaryList.fromJson(Map<String, dynamic> json) => UserDiaryList(
        diaryId: json["diaryId"],
        diaryContent: json["diaryContent"],
        diaryScore: json["diaryScore"],
        emotions: List<Emotion>.from(
            json["emotions"].map((x) => Emotion.fromJson(x))),
        mets: List<Met>.from(json["mets"].map((x) => Met.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "diaryId": diaryId,
        "diaryContent": diaryContent,
        "diaryScore": diaryScore,
        "emotions": List<dynamic>.from(emotions!.map((x) => x.toJson())),
        "mets": List<dynamic>.from(mets!.map((x) => x.toJson())),
      };
}

class Emotion {
  Emotion({
    this.emotionId,
    this.emotionName,
  });

  int? emotionId;
  String? emotionName;

  factory Emotion.fromJson(Map<String, dynamic> json) => Emotion(
        emotionId: json["emotionId"],
        emotionName: json["emotionName"],
      );

  Map<String, dynamic> toJson() => {
        "emotionId": emotionId,
        "emotionName": emotionName,
      };
}

class Met {
  Met({
    this.metId,
    this.metName,
  });

  int? metId;
  String? metName;

  factory Met.fromJson(Map<String, dynamic> json) => Met(
        metId: json["metId"],
        metName: json["metName"],
      );

  Map<String, dynamic> toJson() => {
        "metId": metId,
        "metName": metName,
      };
}
