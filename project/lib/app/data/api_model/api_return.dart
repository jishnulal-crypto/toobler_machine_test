import 'package:project/app/models/employee_model.dart';

class ApiReturn {
  List<Employee> data;

  ApiReturn({required this.data});

  factory ApiReturn.fromJson(dynamic json) {
    return ApiReturn(
      data: (json as List)
          .map((employeeJson) => Employee.fromJson(employeeJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'data': data.map((employee) => employee.toJson()).toList()};
  }
}
