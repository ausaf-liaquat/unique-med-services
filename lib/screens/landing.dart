import 'package:flutter/material.dart';
import 'package:ums_staff/screens/document/documents.dart';
import 'package:ums_staff/screens/profile/profile.dart';
import 'package:ums_staff/screens/schedule/schedule.dart';
import 'package:ums_staff/screens/shift/edit.dart';
import 'package:ums_staff/screens/shift/shifts.dart';
import 'package:ums_staff/screens/wallet/payout_avtivity.dart';
import 'package:ums_staff/screens/wallet/wallet.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ums_staff/shared/theme/color.dart';

import '../widgets/others/bottom_sheet.dart';
import 'document/create.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});
  static const route = '/';
  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _tabs = <Widget>[
    ScheduleScreen(),
    ShiftScreen(),
    WalletScreen(),
    DocumentScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> icons = <Widget>[
      IconButton(
          onPressed: () {}, icon: const Icon(Icons.notifications_outlined)),
      IconButton(
          onPressed: () {
            Navigator.pushNamed(context, FilterShiftScreen.route);
          },
          icon: const Icon(Icons.tune)),
      IconButton(
          onPressed: () {
            Navigator.pushNamed(context, PayoutActivtyScreen.route);
          },
          icon: const Icon(Icons.schedule)),
      IconButton(
          onPressed: () {
            Navigator.pushNamed(context, CreateDocumentScreen.route);
          },
          icon: const Icon(Icons.cloud_upload_outlined)),
      const ProfileBottomSheet()
    ];

    // bool smallDevice = MediaQuery.of(context).size.width >= 375;

    return Scaffold(
        appBar: AppBar(
          leadingWidth: 150,
          leading: Padding(
            padding: const EdgeInsets.only(left: 0),
            child:
                Image.asset('assets/images/app-bar-text-logo.png', width: 107),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: icons[_selectedIndex],
            ),
          ],
        ),
        body: _tabs[_selectedIndex],
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              color: AppColorScheme().black0,
              boxShadow: [
                BoxShadow(
                    color: AppColorScheme().black8,
                    offset: const Offset(0, -1)),
              ],
            ),
            child: GNav(
                tabBackgroundColor: HexColor('#A018F8'),
                // padding: EdgeInsets.symmetric(
                //     vertical: smallDevice ? 12 : 9,
                //     horizontal: smallDevice ? 20 : 17),
                // iconSize: smallDevice ? 24 : 21,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                iconSize: 24,
                selectedIndex: _selectedIndex,
                hoverColor: HexColor('#A018F8'),
                curve: Curves.fastOutSlowIn,
                color: AppColorScheme().black50,
                activeColor: AppColorScheme().black0,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                tabs: [
                  GButton(
                    icon: _selectedIndex == 0
                        ? Icons.event_note
                        : Icons.event_note_outlined,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  GButton(
                    icon: _selectedIndex == 1
                        ? Icons.drafts
                        : Icons.drafts_outlined,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  // GButton(
                  //   icon: _selectedIndex == 2
                  //       ? Icons.account_balance_wallet
                  //       : Icons.account_balance_wallet_outlined,
                  //   borderRadius: const BorderRadius.all(Radius.circular(8)),
                  // ),
                  GButton(
                    icon: _selectedIndex == 2
                        ? Icons.description
                        : Icons.description_outlined,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  GButton(
                    icon: _selectedIndex == 3
                        ? Icons.person
                        : Icons.person_outlined,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  )
                ]),
          ),
        ));
  }
}
