import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_app/src/model/auth/register_user.dart';
import 'package:test_app/src/model/auth/validate_nickname_result.dart';

import '../../model/auth/register_result.dart';

class RegisterServices {
  final client = http.Client();
  final result = ValidateNicknameResult();
  String url = "http://3.36.114.174:8080/api/v1/user";
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
  Future<RegisterResult> signup(RegisterUser user) async {
    final response = await client.post(Uri.parse('$url/sign-up'),
        headers: headers, body: jsonEncode(user));
    return registerResultFromJson(response.body);
  }
}
