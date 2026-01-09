import 'package:dio/dio.dart';

class DioClient {
  static Dio createDio(){
    final dio=Dio(
      BaseOptions(
        baseUrl: "https://dummyjson.com",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      )

    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print("REQUEST:${options.method} ${options.path}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          
          print("RESPONSE:${response.statusCode}");
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print("ERROR:${e.message}");
          return handler.next(e);
        },
      )
    );
    return dio;
  }
}