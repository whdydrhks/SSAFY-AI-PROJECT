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
      final refreshToken = await storage.read(key: "refreshToken");

      print('accessToken: $accessToken');
      print('refreshToken: $refreshToken');

      options.headers['Content-Type'] = 'application/json';
      options.headers['Authorization'] = accessToken ?? '';
      // options.headers['Authorization'] =
      //     'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiLsoJXtmITshJ0iLCJhdXRoIjoiUk9MRV9VU0VSIiwiZXhwIjoxNjgwMTUyNDg4fQ.swD6mxALAeTaCXoaZFnCL7xkGunxTuQ7D63rNmLdves';
      // return handler.next(options);
    },
  ));

  return dio;
}
