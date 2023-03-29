import 'package:flutter/material.dart';
import '../../screens/login.dart';
import '../../screens/splash_screen.dart';
import 'names.dart';

var appRoutes = <String, WidgetBuilder>{
  AppRoutes.splashScreen: (context) => const SplashScreen(),
  AppRoutes.login: (context) => const LoginScreen(),
};
