import "../../utils/type_definition.dart";

class ResponseModel<T> {
  const ResponseModel({
    required this.statusCode,
    required this.headers,
    required this.body,
  });

  factory ResponseModel.fromJson(JSON json, bool needConvert, int statusCode) {
    return ResponseModel(
      statusCode: statusCode,
      headers: ResponseHeadersModel.fromJson(
        json,
      ),
      body: needConvert ? json["value"] as T : json as T,
    );
  }

  final ResponseHeadersModel? headers;
  final int statusCode;
  final T body;
}

class ResponseHeadersModel {
  ResponseHeadersModel({
    this.error,
    this.message,
    this.code,
  });

  factory ResponseHeadersModel.fromJson(JSON json) {
    return ResponseHeadersModel(
      error: json["error"],
      message: json["message"] as String?,
      code: json["code"] as int?,
    );
  }
  bool? error;
  String? message;
  int? code;
}
