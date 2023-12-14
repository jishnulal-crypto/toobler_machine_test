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

  @override
  void onInit() {
    super.onInit();
    ever(employees, (_) {
      print('employees length: ${employees.length}');
    });

    fetchData();
  }

  void fetchData() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print(response.body);

        employees.assignAll(data
            .map((e) => Employee(
                id: e['id'], name: e['name'], city: e['address']['city']))
            .toList());
        filteredEmployees.assignAll(employees);
        print("within length: ${employees.length}");
        cities.addAll(employees.map((e) => e.city).toList());
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  void filterByCity(String city) {
    print("controlle came here right");
    selectedCity.value = city;
    if (city == 'All') {
      filteredEmployees.assignAll(employees);
    } else {
      filteredEmployees
          .assignAll(employees.where((e) => e.city == city).toList());
    }
  }
}
