import 'dart:convert';

PostChatBotModel postChatBotModelFromJson(String str) =>
    PostChatBotModel.fromJson(json.decode(str));

String postChatBotModelToJson(PostChatBotModel data) =>
    json.encode(data.toJson());

class PostChatBotModel {
  PostChatBotModel({this.text});

  String? text;

  factory PostChatBotModel.fromJson(Map<String, dynamic> json) =>
      PostChatBotModel(
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
      };
}
