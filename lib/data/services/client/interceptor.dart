import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base/core/utils/log_utils.dart';
import 'package:get/get.dart' hide Response;

import '../../../core/utils/preferences.dart';
import '../../../routes/routes_name.dart';
import 'header_builder.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);

    String? token = Preferences.token;

    if (token != null) {
      options.headers = HeaderBuilder().setBearerToken(token).build();
    }

    if (kDebugMode) {
      logger.i("Api Request \n"
          "Method : ${options.method}\n"
          "Url : ${options.baseUrl + options.path}\n"
          "Query Param : ${options.queryParameters}\n"
          "body : ${options.data}\n"
          "Header : ${options.headers}\n");
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i("Api Response \n"
        "Url : ${response.requestOptions.baseUrl + response.requestOptions.path}\n"
        "data : ${const JsonEncoder.withIndent(' ').convert(response.data)}");

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    if (err.response?.statusCode == 401) {
      Preferences.logout();
      Get.offAllNamed(RoutesName.login);
    }
  }
}
