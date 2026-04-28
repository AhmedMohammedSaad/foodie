import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../errors/exceptions.dart';
import 'api_consumer.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.responseType = ResponseType.plain;
    
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: true,
        responseHeader: true,
        request: true,
        requestBody: true,
      ));
    }
  }

  @override
  Future delete(String path, {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.delete(path, data: data, queryParameters: queryParameters);
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioException(error);
    }
  }

  @override
  Future get(String path, {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(path, data: data, queryParameters: queryParameters);
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioException(error);
    }
  }

  @override
  Future patch(String path, {Object? data, Map<String, dynamic>? queryParameters, bool isFormData = false}) async {
    try {
      final response = await dio.patch(
        path,
        data: isFormData ? FormData.fromMap(data as Map<String, dynamic>) : data,
        queryParameters: queryParameters,
      );
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioException(error);
    }
  }

  @override
  Future post(String path, {Object? data, Map<String, dynamic>? queryParameters, bool isFormData = false}) async {
    try {
      final response = await dio.post(
        path,
        data: isFormData ? FormData.fromMap(data as Map<String, dynamic>) : data,
        queryParameters: queryParameters,
      );
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioException(error);
    }
  }

  dynamic _handleResponseAsJson(Response<dynamic> response) {
    return jsonDecode(response.data.toString());
  }

  void _handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw ServerException("Connection timeout");
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case 400:
            throw ServerException("Bad request");
          case 401:
          case 403:
            throw ServerException("Unauthorized");
          case 404:
            throw ServerException("Not found");
          case 500:
            throw ServerException("Internal server error");
        }
        break;
      case DioExceptionType.cancel:
        break;
      default:
        throw ServerException("Check your internet connection");
    }
  }
}
