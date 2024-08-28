import 'package:dio/dio.dart';

class DioExceptionHandle implements Exception {
  DioExceptionHandle.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionError:
        message = "Connection failed due to internet connection";
        break;

      case DioExceptionType.badResponse:
        message = _handleError(
            dioError.response!.statusCode!, dioError.response!.data);
        break;

      default:
        message = "Something went wrong";
        break;
    }
  }

  String? message;

  String _handleError(int statuscode, dynamic error) {
    switch (statuscode) {
      //can write according to Api doc
      case 500:
        return "Internal server error";
      default:
        return "Something went wrong";
    }
  }
}
