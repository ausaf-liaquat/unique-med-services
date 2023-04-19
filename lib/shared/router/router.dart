import 'package:flutter/material.dart';

import '../../screens/forms/BCA_form/emplotment_bca_form.dart';
import '../../screens/forms/w9_form/w9_form.dart';
import '../../screens/login.dart';
import '../../screens/landing.dart';
import '../../screens/other/support.dart';
import '../../screens/profile/edit.dart';
import '../../screens/schedule/details.dart';
import '../../screens/shift/details.dart';
import '../../screens/shift/edit.dart';
import '../../screens/wallet/direct_deposit.dart';
import '../../screens/wallet/payout_avtivity.dart';
import '../../screens/document/create.dart';
import '../../screens/wallet/payout_detail.dart';

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
};
