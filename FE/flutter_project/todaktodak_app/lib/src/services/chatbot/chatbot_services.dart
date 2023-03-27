import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_app/src/model/diary/post_chatbot_result.dart';

class ChatbotServices {
  final client = http.Client();
  Map<String, String> headers = {
    'Content-type': 'application/json',
  };
  String url = "http://192.168.31.46:8080/api/v1/input/";
  Future<PostChatBotResult> postText(var model) async {
    final response = await client.post(Uri.parse(url),
        headers: headers,
        body: jsonEncode(<String, String>{"text": model.text}));
    return postChatBotResultFromJson(response.body);
  }
}
