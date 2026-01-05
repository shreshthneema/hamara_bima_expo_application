import "../../utils/constants.dart";
import "../../utils/static_variable.dart";

import "../../utils/type_definition.dart";

import "api_interface.dart";
import "dio_manager.dart";
import "error_handling.dart";
import "response_model.dart";

import "package:dio/dio.dart";

class ApiService implements ApiInterface {
  late final DioService _dioService;

  factory ApiService() {
    // Initialize the DioService if not already initialized
    if (!_isInitialized) {
      instance._dioService = DioService(
        dioClient: Dio(
          BaseOptions(
            baseUrl: StaticVariable.BASE_URL,
            contentType: "application/json",
            responseType: ResponseType.json,
            connectTimeout: const Duration(seconds: 30),
            headers: {},
          ),
        ),
      );
      _isInitialized = true;
    }
    return instance;
  }

  ApiService._internal();

  static final ApiService instance = ApiService._internal();

  static bool _isInitialized = false;

  // Method to check if DioService has been initialized
  bool get isDioServiceInitialized => _isInitialized;

  // ApiService() : _dioService = DioService(dioClient: Dio());

  // @override
  // Future<List<T>> getCollectionData<T>({
  //   required String endpoint,
  //   required T Function(JSON responseBody) converter,
  //   JSON? queryParams,
  //   CancelToken? cancelToken,
  //   bool requiresAuthToken = true,
  //   JSON? headers,
  // }) async {
  //   List<Object?> body;
  //
  //   try {
  //     // Entire map of response
  //     final data = await _dioService.get<List<Object?>>(
  //       endpoint: endpoint,
  //       options: Options(
  //         headers: headers,
  //         extra: <String, Object?>{
  //           'requiresAuthToken': requiresAuthToken,
  //         },
  //       ),
  //       queryParams: queryParams,
  //       cancelToken: cancelToken,
  //       needConvert: true,
  //     );
  //
  //     consoleLog('Response from endpoints: $endpoint with query params: $queryParams');
  //
  //     // Items of table as json
  //     body = data.body;
  //   } on Exception catch (ex) {
  //     consoleLog([ex, 'Exception from api'].toString());
  //     throw DioCustomException.fromDioException(ex);
  //   }
  //
  //   try {
  //     // Returning the deserialized objects
  //     return body.map((dataMap) => converter(dataMap! as JSON)).toList();
  //   } on Exception catch (ex) {
  //     consoleLog([ex, 'Exception from converter'].toString());
  //     throw DioCustomException.fromParsingException(ex);
  //   }
  // }

  @override
  Future<T> getDocumentData<T>({
    required String endpoint,
    required T Function(JSON response) converter,
    JSON? queryParams,
    JSON? headers,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
  }) async {
    JSON body;
    try {
      consoleLog("Fetching data: $endpoint with query params: $queryParams and headers: $headers.");

      // Entire map of response
      final data = await _dioService.get<JSON>(
        endpoint: endpoint,
        queryParams: queryParams,
        options: Options(
          headers: headers,
          extra: <String, Object?>{
            "requiresAuthToken": requiresAuthToken,
          },
        ),
        needConvert: false,
        cancelToken: cancelToken,
      );

      body = data.body;
    } on Exception catch (ex) {
      consoleLog([ex, "Exception from api"].toString());
      throw DioCustomException.fromDioException(ex);
    }

    try {
      // Returning the deserialized object
      return converter(body);
    } on Exception catch (ex) {
      consoleLog([ex, "Exception from converter"].toString());

      throw DioCustomException.fromParsingException(ex);
    }
  }

  @override
  Future<T> setData<T>({
    required String endpoint,
    required JSON data,
    required T Function(JSON response) converter,
    CancelToken? cancelToken,
    JSON? headers,
    bool requiresAuthToken = true,
    JSON? queryParams,
  }) async {
    consoleLog("$endpoint Uploading data: $data with query params: $queryParams and headers: $headers.");

    ResponseModel<JSON> response;
    try {
      // Entire map of response
      response = await _dioService.post<JSON>(
        endpoint: endpoint,
        data: data,
        options: Options(
          extra: <String, Object?>{
            "requiresAuthToken": requiresAuthToken,
          },
        ),
        cancelToken: cancelToken,
        queryParams: queryParams,
      );
    } on Exception catch (ex) {
      consoleLog([ex, "Exception from api"].toString());

      throw DioCustomException.fromDioException(ex);
    }

    try {
      // Returning the serialized object
      return converter(response.body);
    } on Exception catch (ex) {
      consoleLog([ex, "Exception from converter"].toString());

      throw DioCustomException.fromParsingException(ex);
    }
  }

  Future<T> setFile<T>({
    required String endpoint,
    required FormData data,
    required T Function(JSON response) converter,
    required Future<FormData> Function() formDataFactory,
    CancelToken? cancelToken,
    JSON? headers,
    bool requiresAuthToken = true,
    JSON? queryParams,
  }) async {
    consoleLog("$endpoint Uploading data: $data with query params: $queryParams and headers: $headers.");

    ResponseModel<JSON> response;
    try {
      // Entire map of response
      response = await _dioService.postFiles<JSON>(
        endpoint: endpoint,
        data: data,
        options: Options(
          extra: <String, Object?>{
            "requiresAuthToken": requiresAuthToken,
            "formDataFactory": formDataFactory,
          },
        ),
        cancelToken: cancelToken,
        queryParams: queryParams,
      );
    } on Exception catch (ex) {
      consoleLog([ex, "Exception from api"].toString());

      throw DioCustomException.fromDioException(ex);
    }

    try {
      // Returning the serialized object
      return converter(response.body);
    } on Exception catch (ex) {
      consoleLog([ex, "Exception from converter"].toString());

      throw DioCustomException.fromParsingException(ex);
    }
  }

  @override
  Future<void> patchData<T>({
    required String endpoint,
    required JSON data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
  }) async {
    consoleLog("$endpoint Changing data: $data .");

    try {
      // Entire map of response
      await _dioService.patch<JSON>(
        endpoint: endpoint,
        data: data,
        options: Options(
          extra: <String, Object?>{
            "requiresAuthToken": requiresAuthToken,
          },
        ),
        cancelToken: cancelToken,
      );
    } on Exception catch (ex) {
      consoleLog([ex, "Exception from api"].toString());

      throw DioCustomException.fromDioException(ex);
    }
    //
    // try {
    //   // Returning the serialized object
    //   return converter(response);
    // } on Exception catch (ex) {
    //   consoleLog([ex, 'Exception from converter'].toString());
    //
    //   throw DioCustomException.fromParsingException(ex);
    // }
  }

  Future<void> deleteData<T>({
    required String endpoint,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
  }) async {
    consoleLog("Delete === $endpoint ");

    try {
      // Entire map of response
      await _dioService.delete<JSON>(
        endpoint: endpoint,
        options: Options(
          extra: <String, Object?>{
            "requiresAuthToken": requiresAuthToken,
          },
        ),
        cancelToken: cancelToken,
      );
    } on Exception catch (ex) {
      consoleLog([ex, "Exception from api"].toString());

      throw DioCustomException.fromDioException(ex);
    }
    //
    // try {
    //   // Returning the serialized object
    //   return converter(response);
    // } on Exception catch (ex) {
    //   consoleLog([ex, 'Exception from converter'].toString());
    //
    //   throw DioCustomException.fromParsingException(ex);
    // }
  }

  @override
  void cancelRequests({CancelToken? cancelToken}) {
    _dioService.cancelRequests(cancelToken: cancelToken);
  }
}
