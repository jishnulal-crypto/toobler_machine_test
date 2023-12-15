import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:project/app/data/inherited_widgets/environment_config.dart';
import 'package:project/app/data/network/api_urls.dart';

import 'app/routes/app_pages.dart';

void main() async {
  ApiUrls.setEnvironment(development: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 960),
        builder: (context, child) {
          return EnvironmentConfig(
            environment: WhichEnvironment.base,
            child: GetMaterialApp(
              title: "Application",
              initialRoute: AppPages.INITIAL,
              getPages: AppPages.routes,
            ),
          );
        });
  }
}
