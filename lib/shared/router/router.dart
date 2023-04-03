import 'package:flutter/material.dart';
import '../../screens/landing.dart';
import '../../screens/login.dart';
import 'names.dart';

var appRoutes = <String, WidgetBuilder>{
  LandingScreen.route: (context) => const LandingScreen(),
  LoginScreen.route: (context) => const LoginScreen(),
};
