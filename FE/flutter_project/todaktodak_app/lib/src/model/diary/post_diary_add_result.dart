import 'dart:convert';

PostDiaryAddResult postDiaryAddResultFromJson(String str) => PostDiaryAddResult.fromJson(json.decode(str));

String postDiaryAddResultToJson(PostDiaryAddResult data) => json.encode(data.toJson());

class PostDiaryAddResult {
    PostDiaryAddResult({
        this.state,
        this.result,
        this.message,
        this.data,
        this.error,
    });

    int? state;
    String? result;
    String? message;
    List<dynamic>? data;
    List<dynamic>? error;

    factory PostDiaryAddResult.fromJson(Map<String, dynamic> json) => PostDiaryAddResult(
        state: json["state"],
        result: json["result"],
        message: json["message"],
        data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
        error: json["error"] == null ? [] : List<dynamic>.from(json["error"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "state": state,
        "result": result,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
        "error": error == null ? [] : List<dynamic>.from(error!.map((x) => x)),
    };
}
