import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Directory'),
      ),
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          _buildCityFilter(),
          _buildEmployeeList(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('Employee Directory'),
      ),
    );
  }

  Widget _buildCityFilter() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          height: 100,
          child: Row(
            children: [
              Text('Filter by City: '),
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.cities.length,
                  itemBuilder: (context, index) {
                    final city = controller.cities[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: OutlinedButton(
                        onPressed: () => controller.filterByCity(city),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: controller.selectedCity.value == city
                              ? Colors.blue
                              : null, // Change the background color when selected
                        ),
                        child: Text(city),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmployeeList() {
    print("is here comtroll");
    return Obx(
      () => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            print("something");
            print(controller.filteredEmployees[index].name);
            final employee = controller.filteredEmployees[index];
            return ListTile(
              title: Text(
                employee.name,
              ),
              subtitle: Text(employee.city),
              // Add your image widget here
            );
          },
          childCount: controller.filteredEmployees.length,
        ),
      ),
    );
  }
}
