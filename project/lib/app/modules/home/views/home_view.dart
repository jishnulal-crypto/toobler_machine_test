import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text('Employees'),
        background: Image.asset(
          'assets/images/moon-2762111_1280.jpg',
          width: 400.w,
          fit: BoxFit
              .cover, // Set BoxFit.cover to make the image cover the entire SliverAppBar
        ),
      ),
    );
  }

  Widget _buildCityFilter() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Container(
          width: 30.w,
          height: 30,
          child: Row(
            children: [
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.cities.length,
                    itemBuilder: (context, index) {
                      final city = controller.cities[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: OutlinedButton(
                          onPressed: () => controller.filterByCity(city, index),
                          style: OutlinedButton.styleFrom(
                            backgroundColor:
                                index == controller.selectedCityIndex.value
                                    ? Colors.blue
                                    : Colors.white,
                            side: BorderSide(color: Colors.blue),
                          ),
                          child: Text(city),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmployeeList() {
    return Obx(
      () => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
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
                  onTap: () {
                    controller.goToDetailView(employee);
                  },
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
