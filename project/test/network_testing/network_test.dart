import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:project/app/data/api_model/api_return.dart';
import 'package:project/app/models/employee_model.dart';
import 'package:project/app/modules/home/controllers/home_controller.dart';
import 'package:project/app/modules/home/providers/user_provider.dart';

class MockHomeProvider extends Mock implements HomeProvider {}

void networktesting() {
  group('HomeController API Fetching', () {
    test('fetchData from employees', () async {
      // Create a mock HomeProvider
      final mockProvider = MockHomeProvider();
      final homeController = HomeController();
      ApiReturn apiReturn = await mockProvider.getEmployees();
      expect(apiReturn.data.length, greaterThan(0));
      // Add a message to the console
      print(
          'Test: fetchData from employees - API returned ${apiReturn.data.length} employees');

      // Add more assertions based on your specific requirements
    });

    test('fetchData from cities', () async {
      // Create a mock HomeProvider
      final mockProvider = MockHomeProvider();
      final homeController = HomeController();
      ApiReturn apiReturn = await mockProvider.getEmployees();
      List<String> citycount = apiReturn.data.map(
        (e) {
          return e.address!.city!;
        },
      ).toList();
      expect(citycount, greaterThan(0));

      // Add a message to the console
      print(
          'Test: fetchData from cities - Found ${citycount.length} unique cities');

      // Add more assertions based on your specific requirements
    });
  });
}
