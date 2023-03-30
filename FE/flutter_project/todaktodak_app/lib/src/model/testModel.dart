class ResponseData {
  final Map<String, Map<String, int>> data;

  ResponseData({required this.data});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      data:
          json.map((key, value) => MapEntry(key, Map<String, int>.from(value))),
    );
  }
}
