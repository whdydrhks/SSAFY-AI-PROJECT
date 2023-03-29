import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

Future<Dio> authDio() async {
  final options = BaseOptions(
    baseUrl: '${dotenv.env['BASE_URL']}',
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 5),
  );
  var dio = Dio(options);

  dio.interceptors.clear();

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      // 헤더 추가
      final accessToken = await storage.read(key: "accessToken");
      print('accessToken: $accessToken');
      options.headers['Content-Type'] = 'application/json';
      options.headers['Authorization'] = '${accessToken ?? ''}';
      return handler.next(options);
    },
  ));

  return dio;
}
