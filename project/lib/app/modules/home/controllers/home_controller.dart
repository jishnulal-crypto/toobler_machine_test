import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project/app/modules/detail/controllers/detail_controller.dart';
import 'package:project/app/modules/detail/views/detail_view.dart';
import 'dart:convert';

import '../../../models/employee_model.dart';

class HomeController extends GetxController {
  var employees = <Employee>[].obs;
  var filteredEmployees = <Employee>[].obs;
  var cities = <String>['All'].obs;
  var selectedCity = 'All'.obs;
  RxInt selectedCityIndex = RxInt(-1);
  Rx<Color> color = Rx<Color>(Colors.blue);

  @override
  void onInit() {
    super.onInit();
    ever(employees, (_) {
      print('employees length: ${employees.length}');
    });

    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print(response.body);

        employees.assignAll(data.map((e) => Employee.fromJson(e)).toList());
        filteredEmployees.assignAll(employees);
        print("within length: ${employees.length}");
        cities.addAll(employees.map((e) => e.address?.city ?? '').toList());
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching data: $error");
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
    print("happened $city");
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
