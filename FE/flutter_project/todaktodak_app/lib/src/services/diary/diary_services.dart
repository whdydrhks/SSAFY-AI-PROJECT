import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test_app/src/model/diary/delete_diary_result.dart';
import 'package:test_app/src/model/diary/get_diary_detail_result.dart';
import 'package:test_app/src/model/diary/get_diary_list_result.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/src/model/diary/put_diary_update.dart';
import 'package:test_app/src/model/diary/put_diary_update_result.dart';

class DiaryServices {
  String url = "http://3.36.114.174:8080/api/v1/diary";
  final client = http.Client();
  Map<String, String> headers = {
    'Content-type': 'application/json',
  };

  //다이어리 Dio

  Future<Dio> diaryDio(var accessToken, var refreshToken) async {
    final options = BaseOptions(
      baseUrl: '${dotenv.env['BASE_URL']}',
      headers: {
        'Authorization': accessToken,
        'Content-Type': 'application/json'
      },
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    );

    final dio = Dio(options);

    dio.interceptors.clear();
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        return handler.next(options);
      },
      onError: (error, handler) async {
        // 새로운 토큰 발급
        if (error.response?.statusCode == 401) {
          // 새로운 토큰으로 요청을 재시도합니다.
          final newToken = await reissue();
          final request = error.requestOptions
            ..headers['Authorization'] = 'Bearer $newToken';
        }
        return handler.next(error);
      },
    ));

    return dio;
  }

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

  Future<PutDiaryUpdateResult> putDiary(PutDiaryUpdate diary) async {
    final response = await client.put(Uri.parse("$url/update"),
        headers: headers, body: jsonEncode(diary));
    return putDiaryUpdateResultFromJson(response.body);
  }
}
