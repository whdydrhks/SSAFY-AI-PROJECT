import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:test_app/src/controller/dashboard/dashboard_controller.dart';
import 'package:test_app/src/model/diary/delete_diary_result.dart';
import 'package:test_app/src/model/diary/get_diary_detail_result.dart';
import 'package:test_app/src/model/diary/get_diary_list_result.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/src/model/diary/put_diary_update.dart';
import 'package:test_app/src/model/diary/put_diary_update_result.dart';

import '../../components/analysis/feel_relation_bar_chart.dart';

class DiaryServices {
  String url = "http://3.36.114.174:8080/api/v1/diary";
  final client = http.Client();
  Map<String, String> headers = {
    'Content-type': 'application/json',
  };
  final storage = const FlutterSecureStorage();

  //다이어리 Dio

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

  Future<Dio> diaryDio(
      var accessToken, var refreshToken, var refreshTokenExpirationTime) async {
    Timer? timer;
    print(accessToken);
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
      onResponse: (response, hanler) async {
        // 새로운 토큰 발급
        if (response.data["state"] == 401) {
          final newToken = await tokenRefresh(refreshToken);
          // 새로운 토큰으로 요청을 재시도합니다.
          final request = response.requestOptions
            ..headers['Authorization'] = 'Bearer $newToken';
          await dio.request(request.path,
              options: Options(headers: request.headers));
        } else if (response.data["state"] == 200) {
          Get.snackbar("성공", "${response.data["message"]}");
          Get.toNamed("/app");
        }
      },
    ));

    timer = Timer.periodic(const Duration(minutes: 1), (_) {
      final difference =
          DateTime(refreshTokenExpirationTime).difference(DateTime.now());
      if (difference.inMinutes <= 0) {
        timer?.cancel();
        storage.deleteAll();
        Get.offAllNamed("/register");
      }
    });

    return dio;
  }

  tokenRefresh(var refreshToken) async {
    final options = BaseOptions(
      baseUrl: '${dotenv.env['BASE_URL']}',
      headers: {
        'Authorization': refreshToken,
        'Cookie': 'refreshToken=$refreshToken',
        'Content-Type': 'application/json'
      },
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    );

    final dio = Dio(options);

    try {
      final response = await dio.post("/user/reissue");
      if (response.data["state"] == 200) {
        storage.delete(key: "accessToken");
        storage.write(
            key: "accessToken",
            value: "Bearer ${response.data["data"]["accessToken"]}");
        DashBoardController().test();
        return response.data["data"]["accessToken"];
      }
    } on DioError catch (e) {
      logger.e(e.response?.statusCode);
      logger.e(e.response?.data);
      logger.e(e.message);
    }
  }
}
