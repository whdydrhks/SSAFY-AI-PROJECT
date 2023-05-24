import 'dart:convert';

PostChatBotResult postChatBotResultFromJson(String str) =>
    PostChatBotResult.fromJson(json.decode(str));

String postChatBotResultToJson(PostChatBotResult data) =>
    json.encode(data.toJson());

class PostChatBotResult {
  PostChatBotResult({
    this.emotion,
    this.returnText,
  });

  int? emotion;
  String? returnText;

  factory PostChatBotResult.fromJson(Map<String, dynamic> json) =>
      PostChatBotResult(
        emotion: json["emotion"],
        returnText: json["return_text"],
      );

  Map<String, dynamic> toJson() => {
        "emotion": emotion,
        "return_text": returnText,
      };

  @override
  String toString() {
    // TODO: implement toString
    return "PostChatBotResult : (emotion : ${emotion} returnText : ${returnText})";
  }
}
