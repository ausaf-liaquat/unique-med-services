import 'package:flutter/material.dart';
import 'package:ums_staff/shared/router/main.dart';
import 'package:ums_staff/shared/router/names.dart';
import 'package:ums_staff/shared/theme/main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unique Med Service',
      theme: AppThemeData().lightTheme,
      darkTheme: AppThemeData().darkTheme,
      initialRoute: AppRoutes.splashScreen,
      routes: appRoutes,
    );
  }
}
