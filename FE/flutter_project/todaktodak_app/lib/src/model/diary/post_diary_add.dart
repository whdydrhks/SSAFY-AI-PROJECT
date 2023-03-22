import 'dart:convert';

PostDiaryAdd postDiaryAddFromJson(String str) =>
    PostDiaryAdd.fromJson(json.decode(str));

String postDiaryAddToJson(PostDiaryAdd data) => json.encode(data.toJson());

class PostDiaryAdd {
  PostDiaryAdd({
    this.diaryContent,
    this.diaryScore,
    this.diaryEmotionIdList,
    this.diaryMetIdList,
    this.userId,
    this.diaryDetailLineEmotionCountList,
  });

  String? diaryContent;
  int? diaryScore;
  List<int>? diaryEmotionIdList;
  List<int>? diaryMetIdList;
  int? userId;
  List<int>? diaryDetailLineEmotionCountList;

  factory PostDiaryAdd.fromJson(Map<String, dynamic> json) => PostDiaryAdd(
        diaryContent: json["diaryContent"],
        diaryScore: json["diaryScore"],
        diaryEmotionIdList:
            List<int>.from(json["diaryEmotionIdList"].map((x) => x)),
        diaryMetIdList: List<int>.from(json["diaryMetIdList"].map((x) => x)),
        userId: json["userId"],
        diaryDetailLineEmotionCountList: List<int>.from(
            json["diaryDetailLineEmotionCountList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "diaryContent": diaryContent,
        "diaryScore": diaryScore,
        "diaryEmotionIdList":
            List<dynamic>.from(diaryEmotionIdList!.map((x) => x)),
        "diaryMetIdList": List<dynamic>.from(diaryMetIdList!.map((x) => x)),
        "userId": userId,
        "diaryDetailLineEmotionCountList":
            List<dynamic>.from(diaryDetailLineEmotionCountList!.map((x) => x)),
      };
}
