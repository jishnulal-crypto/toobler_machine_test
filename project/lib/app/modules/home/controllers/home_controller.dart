import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../models/employee_model.dart';

class HomeController extends GetxController {
  var employees = <Employee>[].obs;
  var filteredEmployees = <Employee>[].obs;
  var cities = <String>['All'].obs;
  var selectedCity = 'All'.obs;
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
    selectedCity.value = 'All';
  }

  void filterByCity(String city) {
    print("controller came here right");
    selectedCity.value = city;
    if (city == 'All') {
      filteredEmployees.assignAll(employees);
    } else {
      filteredEmployees
          .assignAll(employees.where((e) => e.address!.city == city).toList());
      changeSelectedColor(city);
    }
  }

  void changeSelectedColor(String city) {
    if (selectedCity.value == city) {
      color.value = Colors.blue;
    }
  }
}
