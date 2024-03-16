import 'package:dio/dio.dart';
import 'package:pokemon_app/config/config.dart';

import '../../domain/domain.dart';

class DioProvider {
  
  final Dio _dio;

  DioProvider({
    Dio? dio
  }): _dio = dio ?? Dio(
    BaseOptions(
      baseUrl: Enviroment.pokeAPI,
      validateStatus:(status) {
        return true;
      },
    )
  ); 

  Future<dynamic> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response.data;
    } catch (error) {
      throw _handleError(error);
    }
  }

  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return NetworkException();
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.badResponse:
        case DioExceptionType.badCertificate:
          return ApiFailureException(error.response?.statusCode ?? -1, error.message ?? 'Not found Error');
        default:
          return UnknownFailureException();
      }
    }
    return error;
  }
}