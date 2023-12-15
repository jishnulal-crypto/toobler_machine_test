import 'package:get/get_connect/connect.dart';
import 'package:project/app/data/api_model/api_return.dart';
import 'package:project/app/data/network/api_urls.dart';
import 'package:project/app/data/network/http_service.dart';

class HomeProvider extends GetConnect {
  Future<ApiReturn> getEmployees() async {
    String url = ApiUrls.getUsersUrl(subUrl: 'users');
    ApiReturn apiReturn = await HttpService.get(url);

    return apiReturn;
  }
}
