class AllDiaryModel {
  final String date, day;
  final int id, rating;

  AllDiaryModel.fromJson(Map<String, dynamic> json)
      : id = json['diaryId'],
        date = json['diaryCreateDate'],
        rating = json['diaryScore'],
        day = json['diaryCreatedDayOfWeek'];
}
