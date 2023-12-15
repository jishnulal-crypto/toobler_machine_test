import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project/app/data/api_model/api_return.dart';
import 'package:project/app/data/network/api_urls.dart';
import 'package:project/app/data/network/http_service.dart';
import 'package:project/app/modules/detail/controllers/detail_controller.dart';
import 'package:project/app/modules/detail/views/detail_view.dart';
import 'package:project/app/modules/home/providers/user_provider.dart';
import 'dart:convert';

import '../../../models/employee_model.dart';

class HomeController extends GetxController {
  var employees = <Employee>[].obs;
  var filteredEmployees = <Employee>[].obs;
  var cities = <String>['All'].obs;
  var selectedCity = 'All'.obs;
  RxInt selectedCityIndex = RxInt(-1);
  Rx<Color> color = Rx<Color>(Colors.white);
  HomeProvider provider = HomeProvider();
  var isLoading = true.obs;

  void changeStatus() async {
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final apiReturn = await provider.getEmployees();
      employees.assignAll(apiReturn.data);
      filteredEmployees.assignAll(employees);
      cities.addAll(employees.map((e) => e.address?.city ?? '').toList());
      changeStatus();
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  void setAllTodefault() {
    selectedCityIndex.value = -1; // Reset the selected city index
    selectedCity.value = 'All';
  }

  void filterByCity(String city, int index) {
    selectedCity.value = city;
    selectedCityIndex.value = index; // Update the selected city index
    if (city == 'All') {
      filteredEmployees.assignAll(employees);
    } else {
      filteredEmployees
          .assignAll(employees.where((e) => e.address!.city == city).toList());
    }
  }

  void changeSelectedColor(String city) {
    if (selectedCity.value == city) {
      color.value = Colors.blue;
    } else {
      color.value = Colors.white;
    }
  }

  void goToDetailView(Employee employee) {
    Get.to(() => DetailView(), arguments: employee.toJson());
  }
}
