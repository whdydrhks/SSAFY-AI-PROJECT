import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:test_app/src/config/message.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/src/model/diary/put_diary_update.dart';
import 'package:test_app/src/model/diary/put_diary_update_result.dart';

import '../../components/analysis/feel_relation_bar_chart.dart';

class DiaryServices {
  final storage = const FlutterSecureStorage();

  Future<Dio> diaryDio(
      {required var accessToken, required var refreshToken}) async {
    final options = BaseOptions(
      baseUrl: '${dotenv.env['BASE_URL']}',
      headers: {
        'Authorization': "Bearer $accessToken",
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
        if (response.data["state"] == 401) {
          final newToken = await tokenRefresh(
              accessToken: accessToken, refreshToken: refreshToken);

          final request = response.requestOptions
            ..headers['Authorization'] = 'Bearer $newToken';
          await dio.request(request.path,
              options: Options(headers: request.headers));
        } else if (response.data["state"] == 200) {
          Get.snackbar("", "",
              titleText: Message.title("성공"),
              messageText: Message.message(response.data["message"]));
          Get.offAllNamed("/app");
        }
      },
    ));

    return dio;
  }

  Future<Dio> backupDio(
      {required var accessToken, required var refreshToken}) async {
    final options = BaseOptions(
      baseUrl: '${dotenv.env['BASE_URL']}',
      headers: {
        'Authorization': "Bearer $accessToken",
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
    ));

    return dio;
  }

  Future<Dio> diaryDetailDio(
      {required var accessToken, required var refreshToken}) async {
    final options = BaseOptions(
      baseUrl: '${dotenv.env['BASE_URL']}',
      headers: {
        'Authorization': "Bearer $accessToken",
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
    ));

    return dio;
  }

  tokenRefresh({required var accessToken, required var refreshToken}) async {
    print("토근들아 $accessToken  리프레쉬 $refreshToken");
    final options = BaseOptions(
      baseUrl: '${dotenv.env['BASE_URL']}',
      headers: {
        'Authorization': "Bearer $accessToken",
        'Cookie': 'refreshToken=$refreshToken',
        'Content-Type': 'application/json'
      },
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    );

    final dio = Dio(options);

    try {
      final response = await dio.post("/user/reissue");
      print("토근 재발행 $response");
      if (response.data["state"] == 200) {
        storage.delete(key: "accessToken");
        storage.write(
            key: "accessToken",
            value: "${response.data["data"]["accessToken"]}");
        return response.data["data"]["accessToken"];
      }
    } on DioError catch (e) {
      logger.e(e.response?.statusCode);
      logger.e(e.response?.data);
      logger.e(e.message);
    }
  }
}
