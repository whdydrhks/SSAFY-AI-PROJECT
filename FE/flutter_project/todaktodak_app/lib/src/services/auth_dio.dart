import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
      options.headers['Content-Type'] = 'application/json';
      options.headers['Authorization'] =
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiLsoJXtmITshJ0iLCJhdXRoIjoiUk9MRV9VU0VSIiwiZXhwIjoxNjgwMDcxMTk4fQ.-1u-XYyvBbkRTK5Sqa9KGd7AapfAwAA_d9rCSyNyOG8';
      return handler.next(options);
    },
  ));

  return dio;
}
