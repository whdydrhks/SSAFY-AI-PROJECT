import 'dart:convert';

import 'package:test_app/src/model/diary/post_diary_add.dart';
import 'package:test_app/src/model/diary/post_diary_add_result.dart';
import 'package:http/http.dart' as http;

class PostDiaryServices {
  final client = http.Client();
  String url = "http://3.36.114.174:8080/api/v1/diary/add";
  Map<String, String> headers = {
    'Content-type': 'application/json',
  };

  Future<PostDiaryAddResult> postDiaryAdd(PostDiaryAdd model) async {
    
    final response = await client.post(Uri.parse(url),
        headers: headers, body: jsonEncode(model));
    return postDiaryAddResultFromJson(response.body);
  }
}
