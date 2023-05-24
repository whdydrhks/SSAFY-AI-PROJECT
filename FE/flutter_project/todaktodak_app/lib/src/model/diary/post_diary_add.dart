import 'dart:convert';

PostDiaryAdd postDiaryAddFromJson(String str) =>
    PostDiaryAdd.fromJson(json.decode(str));

String postDiaryAddToJson(PostDiaryAdd data) => json.encode(data.toJson());

class PostDiaryAdd {
  PostDiaryAdd(
      {this.diaryContent,
      this.diaryScore,
      this.diaryEmotionIdList,
      this.diaryMetIdList,
      this.userId,
      this.diaryDetailLineEmotionCountList,
      this.diaryCreateDate});

  String? diaryContent;
  int? diaryScore;
  List<int>? diaryEmotionIdList;
  List<int>? diaryMetIdList;
  int? userId;
  List<int>? diaryDetailLineEmotionCountList;
  String? diaryCreateDate;
  factory PostDiaryAdd.fromJson(Map<String, dynamic> json) => PostDiaryAdd(
      diaryContent: json["diaryContent"],
      diaryScore: json["diaryScore"],
      diaryEmotionIdList:
          List<int>.from(json["diaryEmotionIdList"].map((x) => x)),
      diaryMetIdList: List<int>.from(json["diaryMetIdList"].map((x) => x)),
      userId: json["userId"],
      diaryDetailLineEmotionCountList:
          List<int>.from(json["diaryDetailLineEmotionCountList"].map((x) => x)),
      diaryCreateDate: json["diaryCreateDate"]);

  Map<String, dynamic> toJson() => {
        "diaryContent": diaryContent,
        "diaryScore": diaryScore,
        "diaryEmotionIdList":
            List<dynamic>.from(diaryEmotionIdList!.map((x) => x)),
        "diaryMetIdList": List<dynamic>.from(diaryMetIdList!.map((x) => x)),
        "userId": userId,
        "diaryDetailLineEmotionCountList":
            List<dynamic>.from(diaryDetailLineEmotionCountList!.map((x) => x)),
        "diaryCreateDate": diaryCreateDate
      };

  @override
  String toString() {
    // TODO: implement toString
    return "PostDiaryAdd : (diaryContent : ${diaryContent}, diaryScore :${diaryScore}, diaryEmotionIdList : ${diaryDetailLineEmotionCountList}, diaryMetIdList :${diaryMetIdList}, userId : ${userId} diaryDetailLineEmotionCountList: ${diaryDetailLineEmotionCountList})";
  }
}
