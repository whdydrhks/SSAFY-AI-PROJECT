import 'dart:convert';

import 'package:test_app/src/model/diary/delete_diary_result.dart';
import 'package:test_app/src/model/diary/get_diary_detail_result.dart';
import 'package:test_app/src/model/diary/get_diary_list_result.dart';
import 'package:http/http.dart' as http;

class DiaryServices {
  String url = "http://3.36.114.174:8080/api/v1/diary";
  final client = http.Client();
  Map<String, String> headers = {
    'Content-type': 'application/json',
  };

  Future<GetDiaryListResult> getDiary(var id) async {
    final response = await client.get(Uri.parse("$url/user/${int.parse(id)}"),
        headers: headers);
    return getDiaryListResultFromJson(response.body);
  }

  Future<GetDiaryDetailResult> getDiaryDetail(var id) async {
    final response = await client.get(Uri.parse("$url/${int.parse(id)}"));
    return getDiaryDetailResultFromJson(response.body);
  }

  Future<DeleteDiaryResult> deleteDiary(var id) async {
    final response = await client.put(Uri.parse("$url/delete"),
        headers: headers, body: jsonEncode(int.parse(id)));
    return deleteDiaryResultFromJson(response.body);
  }
}
