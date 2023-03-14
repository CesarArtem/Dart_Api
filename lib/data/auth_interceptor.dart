import 'package:dio/dio.dart';
import 'package:flutterapi/locator_service.dart';

class AuthInterceptor extends QueuedInterceptor {

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
      super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }
  // @override
  // void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
  //   final accessToken=locator.get<AuthCubit>().state.whenOrNull(
  //     success: (userEntity)=>userEntity.accessToken,
  //   );

  //   if (accessToken==null) {
  //     super.onRequest(options, handler);
  //   } else {
  //     final headers=options.headers;
  //     headers['Authorization']='Bearer $accessToken';
  //     super.onRequest(options.copyWith(headers: headers), handler);
  //   }
  // }

  // @override
  // void onError(DioError err, ErrorInterceptorHandler handler) async{
  //   if (err.response?.statusCode==401) {
  //     try {
  //       await locator.get<AuthCubit>().refreshToken();
  //     } on 
  //   }
  // }
}