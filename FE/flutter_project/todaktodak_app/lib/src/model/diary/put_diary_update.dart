import 'dart:convert';

PutDiaryUpdate putDiaryUpdateFromJson(String str) =>
    PutDiaryUpdate.fromJson(json.decode(str));

String putDiaryUpdateToJson(PutDiaryUpdate data) => json.encode(data.toJson());

class PutDiaryUpdate {
  PutDiaryUpdate({
    this.diaryId,
    this.diaryContent,
    this.diaryScore,
    this.diaryEmotionIdList,
    this.diaryMetIdList,
    this.diaryDetailLineEmotionCountList,
  });

  int? diaryId;
  String? diaryContent;
  int? diaryScore;
  List<int>? diaryEmotionIdList;
  List<int>? diaryMetIdList;
  List<int>? diaryDetailLineEmotionCountList;

  factory PutDiaryUpdate.fromJson(Map<String, dynamic> json) => PutDiaryUpdate(
        diaryId: json["diaryId"],
        diaryContent: json["diaryContent"],
        diaryScore: json["diaryScore"],
        diaryEmotionIdList:
            List<int>.from(json["diaryEmotionIdList"].map((x) => x)),
        diaryMetIdList: List<int>.from(json["diaryMetIdList"].map((x) => x)),
        diaryDetailLineEmotionCountList: List<int>.from(
            json["diaryDetailLineEmotionCountList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "diaryId": diaryId,
        "diaryContent": diaryContent,
        "diaryScore": diaryScore,
        "diaryEmotionIdList":
            List<dynamic>.from(diaryEmotionIdList!.map((x) => x)),
        "diaryMetIdList": List<dynamic>.from(diaryMetIdList!.map((x) => x)),
        "diaryDetailLineEmotionCountList":
            List<dynamic>.from(diaryDetailLineEmotionCountList!.map((x) => x)),
      };

  @override
  String toString() {
    // TODO: implement toString
    return "PutDiaryUpdate : (diaryId : ${this.diaryId}, diaryContent : ${this.diaryContent}, diaryScore : ${this.diaryScore}, diaryEmotionIdList : ${this.diaryEmotionIdList}, diaryMetIdList : ${this.diaryMetIdList}, diaryDetailLineEmotionCountList : ${this.diaryDetailLineEmotionCountList})";
  }
}
