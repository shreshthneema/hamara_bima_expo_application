// import 'package:cms_one/core/network/interceptors/api_interceptors.dart';
import "dart:convert";

// import '../../utils/constants.dart';
import "../../utils/constants.dart";

import "../../utils/type_definition.dart";
import "package:dio/dio.dart";

import "interceptors/api_interceptors.dart";
import "response_model.dart";

class DioService {
  final Dio _dio;
  final CancelToken _cancelToken;
  final ApiInterceptor interceptor = ApiInterceptor();

  DioService({
    required Dio dioClient,
  })  : _dio = dioClient,
        _cancelToken = CancelToken() {
    _dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: interceptor.onRequest,
        onResponse: interceptor.onResponse,
        onError: interceptor.onError,
      ),
    );
  }

  /// This method sends a `GET` request to the [endpoint], **decodes**
  /// the response and returns a parsed [ResponseModel] with a body of type [R].

  /// Any errors encountered during the request are caught and a custom
  ///
  /// [queryParams] holds any query parameters for the request.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [options] are special instructions that can be merged with the request.
  Future<ResponseModel<R>> get<R>({
    required String endpoint,
    required bool needConvert,
    JSON? queryParams,
    required Options options,
    CancelToken? cancelToken,
  }) async {
    options.headers ??= <String, dynamic>{};

    options.headers!["Content-Type"] = "application/json";
    final response = await _dio.get(
      endpoint,
      queryParameters: queryParams,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
    );
    consoleLog("Response from api get endpoints: $endpoint == ${response.statusCode} with query params: $queryParams with headers: ${options.headers} with extra: ${options.extra}");

    return ResponseModel<R>.fromJson(response.data!, needConvert, response.statusCode ?? 400);
  }

  Future<ResponseModel<R>> post<R>({
    required String endpoint,
    JSON? data,
    required Options options,
    CancelToken? cancelToken,
    JSON? queryParams,
  }) async {
    options.headers ??= <String, dynamic>{};
    options.headers!["Content-Type"] = "application/json";

    final response = await _dio.post(
      endpoint,
      data: data,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
      queryParameters: queryParams,
    );
    consoleLog("Response from api post endpoints: $endpoint == ${response.statusCode} with headers: ${options.headers} with extra: ${options.extra}");
    var d = response.data is String ? jsonDecode(response.data) : response.data as JSON?;
    return ResponseModel<R>.fromJson(d, false, response.statusCode ?? 400);
  }

  Future<ResponseModel<R>> postFiles<R>({
    required String endpoint,
    FormData? data,
    required Options options,
    CancelToken? cancelToken,
    JSON? queryParams,
  }) async {
    options.headers ??= <String, dynamic>{};

    options.headers!["Content-Type"] = "multipart/form-data";

    final response = await _dio.post(
      endpoint,
      data: data,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
      queryParameters: queryParams,
    );
    consoleLog("Response from api post endpoints: $endpoint == ${response.statusCode} with headers: ${options.headers} with extra: ${options.extra}");
    var d = response.data is String ? jsonDecode(response.data) : response.data as JSON?;
    return ResponseModel<R>.fromJson(d, false, response.statusCode ?? 400);
  }

  Future<void> patch<R>({
    required String endpoint,
    JSON? data,
    required Options options,
    CancelToken? cancelToken,
  }) async {
    options.headers ??= <String, dynamic>{};

    options.headers!["Content-Type"] = "application/json";

    final response = await _dio.patch<JSON>(
      endpoint,
      data: data,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
    );
    consoleLog("Response from api patch endpoints: $endpoint == ${response.statusCode} with headers: ${options.headers} with extra: ${options.extra}");
    // return ResponseModel<R>.fromJson(response.data!, false);
  }

  Future<void> delete<R>({
    required String endpoint, // e.g. '/Users/123'
    required Options options,
    CancelToken? cancelToken,
    JSON? queryParams,
  }) async {
    options.headers ??= <String, dynamic>{};
    options.headers!["Content-Type"] = "application/json";

    final response = await _dio.delete(
      endpoint,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
      queryParameters: queryParams,
    );

    consoleLog("Response from api delete endpoint: $endpoint == ${response.statusCode} with headers: ${options.headers} with extra: ${options.extra}");
  }

  void cancelRequests({CancelToken? cancelToken}) {
    if (cancelToken == null) {
      _cancelToken.cancel("Cancelled");
    } else {
      cancelToken.cancel();
    }
  }
}
