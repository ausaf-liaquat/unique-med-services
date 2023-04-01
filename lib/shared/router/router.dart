import 'package:flutter/material.dart';
import '../../screens/landing.dart';
import '../../screens/login.dart';
import 'names.dart';

var appRoutes = <String, WidgetBuilder>{
  AppRoutes.landing: (context) => const LandingScreen(),
  AppRoutes.login: (context) => const LoginScreen(),
};
