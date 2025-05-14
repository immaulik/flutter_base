import 'package:dio/dio.dart';
import 'package:flutter_base/data/handler/api_url.dart';
import 'package:flutter_base/data/services/client/client_service.dart';
import 'package:flutter_base/data/services/client/result.dart';

class AuthRepository extends ClientService {
  Future<Result<BaseResponse, String>> login({
    required Map<String, dynamic> data,
  }) async {
    return request(
      requestType: RequestType.post,
      path: ApiUrls.login,
      data: data,
    );
  }
}
