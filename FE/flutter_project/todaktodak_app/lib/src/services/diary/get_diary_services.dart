import 'package:test_app/src/model/diary/get_diary_list_result.dart';
import 'package:http/http.dart' as http;

class GetDiaryServices {
  String url = "http://3.36.114.174:8080/api/v1/diary/user";
  final client = http.Client();
  Map<String, String> headers = {
    'Content-type': 'application/json',
  };

  Future<GetDiaryListResult> getDiary(var id) async {
   
    final response =
        await client.get(Uri.parse("$url/${int.parse(id)}"), headers: headers);
    return getDiaryListResultFromJson(response.body);
  }
}
