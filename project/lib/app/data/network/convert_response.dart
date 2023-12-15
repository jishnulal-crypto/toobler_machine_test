import 'dart:convert';

import 'package:http/http.dart';
import 'package:project/app/data/api_model/api_return.dart';

Future<ApiReturn> handleResponse(Response response) async {
  // _logRequestOnAlice(response);
  if (response.statusCode == 200) {
    return handleSucessResponse(response);
  } else {
    return handleFailureResponse(response);
  }
}

Future<ApiReturn> handleSucessResponse(Response response) async {
  dynamic map = json.decode(response.body);
  return ApiReturn.fromJson(map);
}

Future<ApiReturn> handleFailureResponse(Response response) async {
  dynamic map = json.decode(response.body);
  return ApiReturn.fromJson(map);
}
