import 'package:flutter/material.dart';
import 'package:ums_staff/screens/Auth/forget_password.dart';

import 'package:ums_staff/screens/auth/change_password.dart';
import 'package:ums_staff/screens/auth/create_account/create_account_form.dart';
import 'package:ums_staff/screens/auth/register.dart';
import 'package:ums_staff/screens/auth/verification.dart';
import 'package:ums_staff/screens/other/BCA_form/emplotment_bca_form.dart';
import 'package:ums_staff/screens/other/notification.dart';
import 'package:ums_staff/screens/other/w9_form/w9_form.dart';
import 'package:ums_staff/screens/auth/login.dart';
import 'package:ums_staff/screens/landing.dart';
import 'package:ums_staff/screens/other/support.dart';
import 'package:ums_staff/screens/profile/edit.dart';
import 'package:ums_staff/screens/schedule/details.dart';
import 'package:ums_staff/screens/shift/details.dart';
import 'package:ums_staff/screens/shift/edit.dart';
import 'package:ums_staff/screens/other/direct_deposit.dart';
import 'package:ums_staff/screens/wallet/payout_avtivity.dart';
import 'package:ums_staff/screens/document/create.dart';
import 'package:ums_staff/screens/wallet/payout_detail.dart';

var appRoutes = <String, WidgetBuilder>{
  LandingScreen.route: (context) => const LandingScreen(),
  LoginScreen.route: (context) => const LoginScreen(),
  PayoutActivtyScreen.route: (context) => const PayoutActivtyScreen(),
  CreateDocumentScreen.route: (context) => const CreateDocumentScreen(),
  EditProfileScreen.route: (context) => const EditProfileScreen(),
  ShiftDetailScreen.route: (context) => const ShiftDetailScreen(),
  ScheduleDetailScreen.route: (context) => const ScheduleDetailScreen(),
  FilterShiftScreen.route: (context) => const FilterShiftScreen(),
  DirectDepositScreen.route: (context) => const DirectDepositScreen(),
  PayoutDetailScreen.route: (context) => const PayoutDetailScreen(),
  W9FormScreen.route: (context) => const W9FormScreen(),
  SupportScreen.route: (context) => const SupportScreen(),
  EmplotmentFormScreen.route: (context) => const EmplotmentFormScreen(),
  CreateAccountScreen.route: (context) => const CreateAccountScreen(),
  VerificationScreen.route: (context) => const VerificationScreen(),
  ForgetPasswordScreen.route: (context) => const ForgetPasswordScreen(),
  ChangePasswordScreen.route: (context) => const ChangePasswordScreen(),
  NotificationScreen.route: (context) => const NotificationScreen(),
  RegisterScreen.route: (context) => const RegisterScreen()
};
