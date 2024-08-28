import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:quiz_app/core/api_const.dart';
import 'package:quiz_app/core/api_method_enum.dart';
import 'package:quiz_app/core/exception_handle.dart';

final apiClientProvider = Provider((ref) => ApiClient());

class ApiClient {
  Future request({
    required String path,
    ApiMethod type = ApiMethod.get,
    dynamic data = const {},
  }) async {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConst.baseUrl,
      ),
    );
    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        error: true,
        compact: true,
        maxWidth: 90,
      ));
    }

    try {
      final result = type == ApiMethod.get
          ? await dio.get(path)
          : type == ApiMethod.put
              ? await dio.put(path, data: data)
              : type == ApiMethod.delete
                  ? await dio.delete(path)
                  : type == ApiMethod.patch
                      ? await dio.patch(path, data: data)
                      : await dio.post(path, data: data);
      return result.data;
    } on DioException catch (e) {
      if (kDebugMode) {
        log("Error is ${e.error}");
        log("Error Response is ${e.response}");
      }
      throw DioExceptionHandle.fromDioError(e);
    }
  }
}
