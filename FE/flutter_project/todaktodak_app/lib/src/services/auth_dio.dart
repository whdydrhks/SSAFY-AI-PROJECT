import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

const storage = FlutterSecureStorage();

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
  ),
);

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
      final refreshToken = await storage.read(key: "refreshToken");

      // print('여기accessToken: $accessToken');

      options.headers['Content-Type'] = 'application/json';
      options.headers['Authorization'] = accessToken ?? '';
      // options.headers['Authorization'] =
      //     'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiLsoJXtmITshJ0iLCJhdXRoIjoiUk9MRV9VU0VSIiwiZXhwIjoxOTk1NjI3ODU3fQ.9uCn7pWTfNmKHHVOcsNpajrWTZmy7raXBy2q8BN79ZE';
      return handler.next(options);
    },
  ),
  );

  return dio;
}
