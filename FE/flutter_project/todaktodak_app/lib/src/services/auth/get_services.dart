import 'package:http/http.dart' as http;
import 'package:test_app/src/model/auth/get_userid_result.dart';

class GetSerivces {
  final client = http.Client();
  String url = "http://3.36.114.174:8080/api/v1/user/nickname";
  Map<String, String> headers = {
    'Content-type': 'application/json',
  };
  Future<GetUserIdResult> getUserId(String nickname) async {
    print('들어왔어 $nickname');
    final response =
        await client.get(Uri.parse("$url/$nickname"), headers: headers);
    return getUserIdResultFromJson(response.body);
  }
}
