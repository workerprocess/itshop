import 'package:dio/dio.dart';

class ApiClient {
  late Dio _dio;
  static const String baseUrl = 'https://api.itshop.com/v1';

  ApiClient() {
    _dio = Dio();
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add authentication headers
        options.headers['Content-Type'] = 'application/json';
        options.headers['Accept'] = 'application/json';
        // options.headers['Authorization'] = 'Bearer $token';
        handler.next(options);
      },
      onResponse: (response, handler) {
        // Log successful responses
        print('Response: ${response.statusCode} - ${response.requestOptions.path}');
        handler.next(response);
      },
      onError: (error, handler) {
        // Handle errors globally
        print('Error: ${error.message}');
        handler.next(error);
      },
    ));

    // Add logging interceptor
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (object) => print(object),
    ));
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.get<T>(
      '$baseUrl$path',
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.post<T>(
      '$baseUrl$path',
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.put<T>(
      '$baseUrl$path',
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.delete<T>(
      '$baseUrl$path',
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}
