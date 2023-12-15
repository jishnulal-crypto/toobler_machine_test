import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:project/app/data/api_model/api_return.dart';
import 'package:project/app/models/employee_model.dart';
import 'convert_response.dart';

class HttpService {
  static Future<ApiReturn> post(String url,
      {Map<String, String>? headers, body}) async {
    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    return await handleResponse(response);
  }

  static Future<ApiReturn> put(String url,
      {Map<String, String>? headers, body}) async {
    final response =
        await http.put(Uri.parse(url), headers: headers, body: body);

    return await handleResponse(response);
  }

  static Future<ApiReturn> get(String url,
      {Map<String, String>? headers}) async {
    final response = await http.get(Uri.parse(url), headers: headers);

    return await handleResponse(response);
  }
}
