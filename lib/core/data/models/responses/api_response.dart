import 'package:dio/dio.dart';

class ApiResponse<T extends Object?>({
  required final T data,
  required final int statusCode,
  required final bool success,
  required final String message,
}) {
  factory fromResponse(Response<dynamic> response) {
    final data = response.data as Map<String, dynamic>;
    final statusCode = response.statusCode ?? 0;

    return ApiResponse<T>(
      data: data['data'] as T,
      statusCode: statusCode,
      success: data['success'] as bool,
      message: data['message'] as String,
    );
  }
}
