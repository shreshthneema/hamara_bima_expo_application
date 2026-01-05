import "../../../utils/constants.dart";
import "../../../utils/type_definition.dart";

import "package:dio/dio.dart";

class ApiInterceptor extends Interceptor {
  ApiInterceptor() : super();

  /// This method intercepts an out-going request before it reaches the
  /// destination.

  // ignore: non_constant_identifier_names
  String get TokenExpiredException => "Invalid session or session already timeout.";

  // final String _token = "";

  // String username1 =
  //     '{"UserName": "${Config.username}", "CompanyDB": "${Config.companyDB}"}';

  // String password1 = Config.password;

  /// [options] contains http request information and configuration.
  /// [handler] is used to forward, resolve, or reject requests.

  /// This method is used to inject any token/API keys in the request.

  /// happen to the intercepted request. It has 3 possible options:
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    JSON configureHeaders = {};

    options.headers.addAll({
      "Content-Type": "application/json",
      "Accept": "application/json",
      // 'Access-Control-Allow-Origin': '*', // Required for CORS support to work
      // 'Access-Control-Allow-Credentials': true, // Required for cookies, authorization headers with HTTPS
      // 'Access-Control-Allow-Headers': 'Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale',
      // 'Access-Control-Allow-Methods': 'POST, GET, OPTIONS',
    });

    if (options.extra["requiresAuthToken"] == true) {
      //     String? userName = SharedPreference.localStorage!.getString(SharedPreference.cardCode);
      //
      // String username1 = '{"UserName": ${StaticVariable.SAPUser}, "CompanyDB": "${StaticVariable.SAPDBName}"}';
      // String password1 = StaticVariable.SAPPassword;
      // String basicAuth = 'Basic ${base64.encode(utf8.encode('$username1:$password1'))}';
      // consoleLog("Here");
      // options.headers.addAll(
      //   {
      //     'Authorization': basicAuth,
      //     //         "Accept": "*/*",
      //     //         "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      //     //         "Access-Control-Allow-Credentials": true, // Required for cookies, authorization headers with HTTPS
      //     //         "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      //     //         "Access-Control-Allow-Methods": "POST, GET, OPTIONS"
      //   },
      // );
      // }
      //   options.extra.remove('requiresAuthToken');
    }

    if (options.extra.containsKey("prefer")) {
      configureHeaders["prefer"] = options.extra["prefer"];
    }

    print(options.headers);

    return handler.next(options);
  }

  /// This method intercepts an incoming response before it reaches Dio.

  /// [response] contains http [Response] info.
  /// [handler] is used to forward, resolve, or reject responses.

  /// If response is successful, it is simply passed on. It may again be
  /// intercepted if there are any after it. If none, it is passed to [Dio].
  ///
  /// response and original request's options.

  /// The [RequestInterceptorHandler] in each method controls the what will
  /// happen to the intercepted response. It has 3 possible options:

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    consoleLog(["onResponse interceptor: ", response.statusCode].toString());

    if (response.statusCode != null && response.statusCode! ~/ 100 == 2) {
      return handler.next(response);
    }

    //Reject all error codes from server except 402 and 200 OK
    return handler.reject(DioException(requestOptions: response.requestOptions, response: response));
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    consoleLog(["onError interceptor:", err.error, err.type, err.response].toString());
    if (err.response != null) {
      if (err.response?.statusCode == 401 && err.response!.data is! String?) {
        // ignore: avoid_dynamic_calls
        final exception = err.response!.data["error"]["message"]["value"];
      }
    }
    super.onError(err, handler);
  }
}
