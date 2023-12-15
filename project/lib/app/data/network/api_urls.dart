import 'package:flutter/material.dart';

enum WhichEnvironment { live, base }

class ApiUrls {
  static String baseUrl = 'https://jsonplaceholder.typicode.com/';
  static String liveUrl = 'liveUrl';
  static String url = '';
  static late WhichEnvironment whichEnvironment;
  ApiUrls.setEnvironment({bool? development, bool? production}) {
    if (development != null) {
      url = baseUrl;
      whichEnvironment = WhichEnvironment.base;
    } else {
      url = liveUrl;
      whichEnvironment = WhichEnvironment.live;
    }
  }
  static String getUsersUrl({required String subUrl}) {
    // Perform login-related URL manipulation
    // For example
    return url + subUrl;
  }
}
