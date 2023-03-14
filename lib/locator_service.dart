

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'data/auth_interceptor.dart';

final locator=GetIt.instance;

Future<void> init() async {

  Dio dio;
  locator.registerLazySingleton(() => {
    dio=Dio(
    BaseOptions(
      baseUrl: "http:/?localhost:8888",
      connectTimeout: 5000,
      receiveTimeout: 3000,
      sendTimeout: 5000
    ),
    ),
    dio.interceptors.add(AuthInterceptor()),
  });
}