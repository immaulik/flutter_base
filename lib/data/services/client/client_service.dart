import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base/core/utils/log_utils.dart';
import 'package:flutter_base/data/handler/api_url.dart';
import 'package:flutter_base/data/services/client/base_response.dart';
import 'package:flutter_base/data/services/client/error_message.dart';
import 'package:flutter_base/data/services/client/interceptor.dart';
import 'package:flutter_base/data/services/client/result.dart';
import 'package:flutter_base/data/services/connectivity_service.dart';
import 'package:flutter_base/routes/routes_name.dart';
import 'package:get/get.dart' hide Response;

import '../../../core/utils/preferences.dart';

export 'base_response.dart';

// 200 = success
// 500 = Internal Server Error
// 401 = Unauthorized
// 403 = Forbidden
// 404 = Not Found

enum RequestType { get, post, delete, put, patch, download }

abstract class ClientService {
  final Dio _dio = Dio();

  Future<Result<BaseResponse<dynamic>, String>> request({
    required RequestType requestType,
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    _dio.options = BaseOptions(
      baseUrl: ApiUrls.baseUrl,
      receiveDataWhenStatusError: true,
      sendTimeout: const Duration(minutes: 1),
      connectTimeout: const Duration(minutes: 2),
      receiveTimeout: const Duration(minutes: 2),
    );
    _dio.interceptors.clear();
    _dio.interceptors.addAll([
      AuthInterceptor(),
    ]);

    Response? response;

    try {
      if (await ConnectivityService.isConnected) {
        switch (requestType) {
          // GET
          case RequestType.get:
            response = await _dio.get(path, queryParameters: queryParameters);
            break;

          // POST
          case RequestType.post:
            response = await _dio.post(path,
                data: data, queryParameters: queryParameters);
            break;

          // PUT
          case RequestType.put:
            response = await _dio.put(path, data: data);
            break;

          // PATCH
          case RequestType.patch:
            response = await _dio.patch(path, data: data);
            break;

          // DELETE
          case RequestType.delete:
            response = await _dio.delete(path);
            break;

          default:
            return throw RequestTypeNotFoundException(
                'The HTTP request mentioned is not found');
        }

        var result = BaseResponse.fromResponse(response.data);
        if (result.success) {
          return Success(result);
        } else {
          return Failure(result.message);
        }
      } else {
        return Failure(ErrorMessage.noInternet);
      }
    } on DioException catch (e) {
      logger.e(e.toString());
      if (e.type == DioExceptionType.connectionTimeout) {
        return Failure(ErrorMessage.tryAgain);
      }
      if (e.response?.statusCode == 422) {
        return Success(BaseResponse.fromResponse(e.response?.data));
      } else if (e.response?.statusCode == 403) {
        Preferences.logout();
        Get.offAllNamed(RoutesName.login);
        return Failure(e.response?.data['message'] ?? ErrorMessage.tryAgain);
      } else if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 404) {
        return Failure(e.response?.data['message'] ?? ErrorMessage.tryAgain);
      } else {
        if (e.response != null && e.response?.data != null) {
          var result = BaseResponse.fromResponse(e.response?.data);
          return Failure(result.message);
        } else {
          return Failure(ErrorMessage.tryAgain);
        }
      }
      //
    } catch (e) {
      logger.i(e.toString());
      return Failure(ErrorMessage.tryAgain);
    }
  }
}

// Request type not found exception
class RequestTypeNotFoundException implements Exception {
  String cause;

  RequestTypeNotFoundException(this.cause);
}
