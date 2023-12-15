import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project/app/data/animations/shimmer_widget.dart';

class CustomShimmerWidgetsClass {
  final Widget? child;
  CustomShimmerWidgetsClass({this.child});

  factory CustomShimmerWidgetsClass.listViewWidget(
      {required int itemCount,
      required double totalHeight,
      required double itemHeight,
      required double itemWidth,
      double? borderRadius,
      required BuildContext context}) {
    return CustomShimmerWidgetsClass(
        child: Container(
      width: double.infinity,
      height: totalHeight,
      child: ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          separatorBuilder: (context, index) => SizedBox(
                width: 10,
              ),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return CustomShimmerWidget(
              child: Container(
                decoration: borderRadius != null
                    ? BoxDecoration(
                        color: Colors.red,
                        borderRadius:
                            BorderRadius.all(Radius.circular(borderRadius)))
                    : null,
                width: itemWidth,
                height: itemHeight,
              ),
            );
          }),
    ));
  }
}
