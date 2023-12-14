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
      body: RefreshIndicator(
        onRefresh: () async {
          await controller
              .fetchData(); // Assuming you have a fetchData method in your HomeController
          controller.setAllTodefault();
        },
        child: CustomScrollView(
          slivers: [
            _buildAppBar(),
            _buildCityFilter(),
            _buildEmployeeList(),
          ],
        ),
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
          height: 50,
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
                          backgroundColor: Colors.blue,
                          side: BorderSide(color: controller.color.value),
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
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(employee.name ?? ''),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text('Username: ${employee.name ?? ''}'),
                      Text('Email: ${employee.address ?? ''}'),
                      Text('Phone: ${employee.phone ?? ''}'),
                      Text('City: ${employee.address!.city ?? ''}'),
                    ],
                  ),
                  trailing: Text(employee.website.toString()),
                  // Add your image widget here if you have an image in your data
                ),
              ),
            );
          },
          childCount: controller.filteredEmployees.length,
        ),
      ),
    );
  }
}
