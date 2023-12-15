import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project/app/modules/home/controllers/home_controller.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffectWidget extends StatelessWidget {
  final Widget child;
  final Widget shimmerChild;
  var controller = Get.find<HomeController>();

  ShimmerEffectWidget({required this.child, required this.shimmerChild});

  @override
  Widget build(BuildContext context) {
    if (controller.isLoading == true) {
      print("inside shi,,er");
      return shimmerChild;
    } else {
      return child;
    }
  }
}

class CustomShimmerWidget extends StatelessWidget {
  final Widget child;
  const CustomShimmerWidget({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        enabled: true,
        period: Duration(seconds: 1),
        baseColor: Colors.grey.withOpacity(0.25),
        highlightColor: Colors.black.withOpacity(0.6),
        child: child);
  }
}
