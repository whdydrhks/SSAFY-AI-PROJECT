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
      return handler.next(options);
    },
  ));

  return dio;
}
