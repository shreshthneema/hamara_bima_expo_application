import "../../utils/type_definition.dart";

import "package:dio/dio.dart";

abstract class ApiInterface {
  const ApiInterface();

  // Future<List<T>> getCollectionData<T>({
  //   required String endpoint,
  //   required T Function(JSON responseBody) converter,
  //   JSON? queryParams,
  //   CancelToken? cancelToken,
  //   bool requiresAuthToken = false,
  // });

  Future<T> getDocumentData<T>({
    required String endpoint,
    required T Function(JSON responseBody) converter,
    JSON? queryParams,
    CancelToken? cancelToken,
    bool requiresAuthToken = false,
  });

  Future<T> setData<T>({
    required String endpoint,
    required JSON data,
    required T Function(JSON response) converter,
    CancelToken? cancelToken,
    bool requiresAuthToken = false,
  });
  Future<void> patchData<T>({
    required String endpoint,
    required JSON data,
    CancelToken? cancelToken,
    bool requiresAuthToken = false,
  });

  void cancelRequests({CancelToken? cancelToken});
}
