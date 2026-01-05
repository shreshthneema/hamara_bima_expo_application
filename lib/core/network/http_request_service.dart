import "dart:convert";
import "error_handling.dart";
import "package:http/http.dart" as http;

enum RequestTypes { GET, POST, PATCH }

class HttpNetworkService {
  static HttpNetworkService? _networkManager;

  factory HttpNetworkService() {
    if (_networkManager == null) {
      _networkManager = HttpNetworkService._internal();
      return _networkManager!;
    } else {
      return _networkManager!;
    }
  }

  HttpNetworkService._internal();

  /// You can create a request with `GET` and `POST` methods.
  ///
  /// `R` should be your response model or your response model list, like as `MyModel` or `List<MyModel>`
  ///
  /// `T` should be your response model, like as `MyModel`
  ///
  /// [path] is your request directory. You don't need to add `/` when adding [path].
  ///
  /// [method] should be `RequestTypes.GET` or `RequestTypes.POST`
  ///
  /// [parseModel] should be an instance from your model which in your response, like as `MyModel()`
  ///
  /// [queryParameters] should be an `Object` and contains your parameters, like as `{"id": 26}`
  ///
  /// [headers] You can add http request headers here. It has default `json` content-type
  ///
  /// It returns `MyModel` or `List<MyModel>` or `null`
  ///
  /// GET Method example:
  /// ```dart
  /// var myUser = await request<List<MyModel>, MyModel>(
  /// path: "todos",
  /// method: RequestTypes.GET,
  /// parseModel: MyModel(),
  /// );
  /// ```
  ///
  /// POST Method example:
  /// ```dart
  /// var myUser = await request<MyModel, MyModel>(
  /// path: 'posts',
  /// method: RequestTypes.POST,
  /// parseModel: MyModel(),
  /// queryParameters: {"title": "foo", "body": "bar", "userId": 1},
  /// );
  /// ```
  Future<T?> request<T>({required String path, required RequestTypes method, required T Function(Map<String, dynamic> response) converter, Map<String, dynamic>? body, Map<String, dynamic>? queryParameters, Map<String, String>? headers}) async {
    headers ??= {"Content-Type": "application/json; charset=UTF-8"};
    headers["Content-Type"] ??= "application/json; charset=UTF-8";

    http.Response? response;

    print(["request from http api == ", path, body, headers]);

    var queryParametersStr = queryParameters?.entries.map((e) => "${e.key}=${e.value}").join("&") ?? "";
    var endUri = Uri.parse(path + (queryParametersStr.isNotEmpty ? "?$queryParametersStr" : ""));

    try {
      switch (method) {
        case RequestTypes.GET:
          response = await http.get(endUri, headers: headers);
        case RequestTypes.POST:
          response = await http.post(endUri, body: jsonEncode(body), headers: headers);
        case RequestTypes.PATCH:
          response = await http.patch(endUri, body: jsonEncode(body), headers: headers);
      }

      print(["response from http api == ", response.statusCode, response.body]);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return _parser<T>(converter, jsonDecode(response.body));
      } else if (response.statusCode == 204) {
        return null;
      } else {
        var m = jsonDecode(response.body)?["error"]?["message"]?["value"];

        final message = m is String ? m : "Something went wrong!!";
        throw DioCustomException(message: message);
      }
    } on Exception catch (e) {
      throw DioCustomException.fromDioException(e);
    }
  }
}

T? _parser<T>(T Function(Map<String, dynamic> response) converter, dynamic data) {
  return converter(data as Map<String, dynamic>) as T?;
}

abstract class INetworkModel<T> {
  Map<String, dynamic> toJson();
  T fromJson(Map<String, dynamic> json);
}
