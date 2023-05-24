import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:test_app/src/controller/auth/register_controller.dart';
import 'package:test_app/src/pages/auth/register_page.dart';

import '../../components/analysis/feel_relation_bar_chart.dart';
import '../../controller/dashboard/dashboard_controller.dart';

class AuthServices {
  final storage = const FlutterSecureStorage();

  Future<Dio> authDio() async {
    final options = BaseOptions(
      baseUrl: '${dotenv.env['BASE_URL']}',
      headers: {'Content-Type': 'application/json'},
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    );

    var dio = Dio(options);

    dio.interceptors.clear();

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      return handler.next(options);
    }));
    return dio;
  }

  Future<Dio> logoutDio(var accessToken, var refreshToken) async {
    final options = BaseOptions(
      baseUrl: '${dotenv.env['BASE_URL']}',
      headers: {
        'Authorization': "Bearer $accessToken",
        'Content-Type': 'application/json'
      },
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    );

    var dio = Dio(options);

    dio.interceptors.clear();

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        return handler.next(options);
      },
      onResponse: (response, hanler) async {
        // 새로운 토큰 발급
        print(response);
        if (response.data["state"] == 401) {
          final newToken = await tokenRefresh(
              accessToken: accessToken, refreshToken: refreshToken);
          // 새로운 토큰으로 요청을 재시도합니다.
          final request = response.requestOptions
            ..headers['Authorization'] = 'Bearer $newToken';
          await dio.request(request.path,
              options: Options(headers: request.headers));
        } else if (response.data["state"] == 200) {
          Get.snackbar("성공", "${response.data["message"]}");
          await storage.deleteAll();
        }
      },
    ));
    return dio;
  }

  tokenRefresh({required var accessToken, required var refreshToken}) async {
    final options = BaseOptions(
      baseUrl: '${dotenv.env['BASE_URL']}',
      headers: {
        'Authorization': accessToken,
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
