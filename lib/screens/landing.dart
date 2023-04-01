import 'package:flutter/material.dart';
import 'package:ums_staff/screens/document/documents.dart';
import 'package:ums_staff/screens/profile/profile.dart';
import 'package:ums_staff/screens/schedule/schedule.dart';
import 'package:ums_staff/screens/shift/shifts.dart';
import 'package:ums_staff/screens/wallet/wallet.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});
  static const tabs = [
    ScheduleScreen(),
    ShiftScreen(),
    WalletScreen(),
    DocumentScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: tabs[0]);
  }
}
