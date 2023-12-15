import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:project/app/modules/home/controllers/home_controller.dart';

void widgetTesting() {
  test(
      "testing the employee list",
      () =>
          testWidgets('Employee List Widget Test', (WidgetTester tester) async {
            // Create a HomeController instance
            final HomeController controller = HomeController();

            // Pump the widget tree
            await tester.pumpWidget(
              MaterialApp(
                home: Scaffold(
                  body: _buildEmployeeList(controller),
                ),
              ),
            );

            // Verify that the employee names are displayed
            expect(find.text('Leanne Graham'), findsOneWidget);
            expect(find.text('Ervin Howell'), findsOneWidget);
            expect(find.text('Clementine Bauch'), findsOneWidget);
            expect(find.text('Patricia Lebsack'), findsOneWidget);
            expect(find.text('Chelsey Dietrich'), findsOneWidget);
            expect(find.text('Mrs. Dennis Schulist'), findsOneWidget);
            expect(find.text('Kurtis Weissnat'), findsOneWidget);
            expect(find.text('Nicholas Runolfsdottir V'), findsOneWidget);
            expect(find.text('Glenna Reichert'), findsOneWidget);
            expect(find.text('Clementina DuBuque'), findsOneWidget);

            // Add more assertions based on your specific UI

            // For example, you can test onTap behavior:
            await tester.tap(find.text('Leanne Graham'));
            await tester.pump();

            // Verify that the expected navigation
          }));
}

Widget _buildEmployeeList(HomeController controller) {
  return Obx(
    () => SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final employee = controller.filteredEmployees[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              // ... your existing container code

              child: ListTile(
                onTap: () {
                  controller.goToDetailView(employee);
                },
                title: Text(employee.name ?? ''),
                // ... your existing ListTile code
              ),
            ),
          );
        },
        childCount: controller.filteredEmployees.length,
      ),
    ),
  );
}
