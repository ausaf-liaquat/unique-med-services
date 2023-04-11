import 'package:flutter/material.dart';
import '../../screens/landing.dart';
import '../../screens/login.dart';
import '../../screens/wallet/payout_avtivity.dart';
import '../../screens/document/create.dart';

var appRoutes = <String, WidgetBuilder>{
  LandingScreen.route: (context) => const LandingScreen(),
  LoginScreen.route: (context) => const LoginScreen(),
  PayoutActivtyScreen.route: (context) => const PayoutActivtyScreen(),
  CreateDocumentScreen.route: (context) => const CreateDocumentScreen(),
};
