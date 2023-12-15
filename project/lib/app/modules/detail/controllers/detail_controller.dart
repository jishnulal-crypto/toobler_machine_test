import 'dart:convert';

import 'package:get/get.dart';
import 'package:project/app/models/employee_model.dart';
import 'package:project/app/modules/home/controllers/home_controller.dart';

import 'package:get/get.dart';
import 'package:project/app/models/employee_model.dart';

import 'dart:convert';

import 'package:get/get.dart';
import 'package:project/app/models/employee_model.dart';

class DetailController extends GetxController {
  final count = 0.obs;
  var employee = Employee().obs;

  @override
  void onInit() {
    setEmployeeData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  // Method to set the employee data from the arguments
  void setEmployeeData() {
    try {
      dynamic arguments = Get.arguments!;
      if (arguments != null) {
        employee.value = Employee.fromJson(arguments);
      }
    } catch (e) {
      print('Error decoding JSON: $e');
    }
  }
}
