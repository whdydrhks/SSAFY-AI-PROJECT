import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:test_app/src/model/auth/register_user.dart';
import 'package:test_app/src/model/auth/validate_nickname_result.dart';

import '../../components/analysis/feel_relation_bar_chart.dart';
import '../../controller/dashboard/dashboard_controller.dart';
import '../../model/auth/register_result.dart';

class RegisterServices {
  final client = http.Client();
  final result = ValidateNicknameResult();
  final storage = const FlutterSecureStorage();

  String url = "https://j8b101.p.ssafy.io/api/v1/user";
  //닉네임 중복 api 통신
  Future<ValidateNicknameResult> findNickname(String nickname) async {
    final response = await client.get(Uri.parse('$url/nickname/$nickname'));
    return validateNicknameResultFromJson(response.body);
  }

  Map<String, String> headers = {
    'Content-type': 'application/json',
  };

  @override
  void dispose() {
    client.close();
  }

  //회원가입 api통신
  // Future<RegisterResult> signup(RegisterUser user) async {
  //   print("받아옴 $user");
  //   final response = await client.post(Uri.parse('$url/sign-up'),
  //       headers: headers, body: jsonEncode(user));
  //   return registerResultFromJson(response.body);
  // }

  Future<Dio> registerDio() async {
    final options = BaseOptions(
      baseUrl: '${dotenv.env['BASE_URL']}',
      headers: {'Content-Type': 'application/json'},
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
    );

    var dio = Dio(options);

    dio.interceptors.clear();

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      return handler.next(options);
    }));
    return dio;
  }
}
