import 'package:flutter/material.dart';
import 'package:ums_staff/screens/login.dart';
import 'package:ums_staff/shared/router/router.dart';
import 'package:ums_staff/shared/theme/theme.dart';

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
      debugShowCheckedModeBanner: false,
      theme: AppThemeData().lightTheme,
      darkTheme: AppThemeData().darkTheme,
      initialRoute: LoginScreen.route,
      routes: appRoutes,
    );
  }
}
