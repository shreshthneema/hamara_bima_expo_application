import "package:dio/dio.dart";
import "../../utils/constants.dart";

enum ExceptionType {
  tokenExpiredException,
  cancelException,
  connectTimeoutException,
  sendTimeoutException,
  receiveTimeoutException,
  fetchDataException,
  formatException,
  unrecognizedException,
  apiException,
  serializationException,
}

class DioCustomException implements Exception {
  DioCustomException({
    required this.message,
    this.code,
    int? statusCode,
    this.exceptionType = ExceptionType.apiException,
  })  : statusCode = statusCode ?? 500,
        name = exceptionType.name;

  factory DioCustomException.fromDioException(Exception error) {
    try {
      consoleLog("${error is DioException} ");
      if (error is DioException) {
        consoleLog(
          '${error.type} ${error.response?.statusCode ?? 'no status'} ${error.response ?? 'no rp'} ${error.message} ${error.response?.data ?? 'no data'} ${error.response?.statusMessage ?? 'no data'}',
        );
        switch (error.type) {
          case DioExceptionType.connectionTimeout:
            return DioCustomException(
              exceptionType: ExceptionType.connectTimeoutException,
              statusCode: error.response?.statusCode,
              message: "Please check your network connection.",
            );
          case DioExceptionType.sendTimeout:
            return DioCustomException(
              exceptionType: ExceptionType.sendTimeoutException,
              statusCode: error.response?.statusCode,
              message: "Failed to send",
            );
          case DioExceptionType.receiveTimeout:
            return DioCustomException(
              exceptionType: ExceptionType.receiveTimeoutException,
              statusCode: error.response?.statusCode,
              message: "Failed to receive",
            );
          case DioExceptionType.badCertificate:
          case DioExceptionType.connectionError:
            return DioCustomException(
              exceptionType: ExceptionType.fetchDataException,
              statusCode: error.response?.statusCode,
              // message: 'Network Error connectivity',
              message: "Unable to connect to the server.",
            );
          case DioExceptionType.badResponse:
            // ignore: avoid_dynamic_calls

            print("response == ${error.response}");
            print("response == data ${error.response?.data}");

            final name =
                // ignore: avoid_dynamic_calls
                error.response?.data.toString();

            var m = error.response?.data.toString();

            final message = m is String ? m : "Something went wrong!!";

            if (name == ExceptionType.tokenExpiredException.name) {
              return DioCustomException(
                exceptionType: ExceptionType.tokenExpiredException,
                code: name,
                statusCode: error.response?.statusCode,
                message: message,
              );
            }
            return DioCustomException(
              message: message,
              code: name,
              exceptionType: ExceptionType.fetchDataException,
              statusCode: error.response?.statusCode,
            );
          case DioExceptionType.cancel:
            return DioCustomException(
              exceptionType: ExceptionType.cancelException,
              statusCode: error.response?.statusCode,
              message: "Request cancelled prematurely",
            );
          case DioExceptionType.unknown:
            return DioCustomException(
              exceptionType: ExceptionType.unrecognizedException,
              statusCode: error.response?.statusCode,
              message: error.response?.statusMessage ?? "Unknown",
            );
        }
      } else {
        return DioCustomException(
          exceptionType: ExceptionType.unrecognizedException,
          message: "Error unrecognized",
        );
      }
    } on FormatException catch (e) {
      return DioCustomException(
        exceptionType: ExceptionType.formatException,
        message: e.message,
      );
    } on Exception catch (_) {
      return DioCustomException(
        exceptionType: ExceptionType.unrecognizedException,
        message: "Error unrecognized",
      );
    }
  }

  factory DioCustomException.fromParsingException(Exception error) {
    // add logging to print stack trace
    consoleLog("$error");
    return DioCustomException(
      exceptionType: ExceptionType.serializationException,
      message: "Failed to parse network response to model or vice versa",
    );
  }

  final String name;
  final String message;
  final String? code;
  final int? statusCode;
  final ExceptionType exceptionType;

  @override
  String toString() => {
        "name": name,
        message: message,
        code: code ?? "no code",
        "statusCode": statusCode ?? "no status",
        "exception type": exceptionType.name,
      }.toString();
}
