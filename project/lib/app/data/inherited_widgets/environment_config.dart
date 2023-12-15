import 'package:flutter/material.dart';
import 'package:project/app/data/network/api_urls.dart';

class EnvironmentConfig extends InheritedWidget {
  final WhichEnvironment environment;

  EnvironmentConfig({
    required this.environment,
    required Widget child,
  }) : super(child: child);

  static EnvironmentConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<EnvironmentConfig>();
  }

  @override
  bool updateShouldNotify(EnvironmentConfig oldWidget) {
    return oldWidget.environment != environment;
  }
}
