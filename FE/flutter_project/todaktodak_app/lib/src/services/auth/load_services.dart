import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_app/src/model/auth/load_user.dart';

class LoadServices {
  String url = 'http://3.36.114.174:8080/api/v1/user/sign-up';
  final client = http.Client();
  Map<String, String> headers = {
    'Content-type': 'application/json',
  };
  Future<bool> postLoadUser(LoadUser user) async {
    final response = await client.post(Uri.parse(url),
        headers: headers, body: jsonEncode(user));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
