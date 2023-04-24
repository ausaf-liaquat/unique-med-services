import 'package:flutter/material.dart';
import 'package:ums_staff/screens/landing.dart';

import '../../shared/theme/color.dart';
import 'link.dart';

class BackLayout extends StatelessWidget {
  const BackLayout({
    super.key,
    required this.page,
    required this.text,
    this.totalTabs = 10,
    this.currentTabs,
  });
  final Widget page;
  final String text;
  final num? totalTabs;
  final num? currentTabs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4),
              child: currentTabs == null
                  ? const SizedBox()
                  : LinearProgressIndicator(
                      value: (currentTabs! / 10) / (totalTabs! / 10),
                      minHeight: 4,
                      backgroundColor: HexColor('#DFF3FB'),
                      color: HexColor('#58BDEA'),
                    )),
          leading: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
          ),
          title: Text(text),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: AppLink(
                  path: LandingScreen.route,
                  child:
                      Image.asset('assets/images/app-bar-logo.png', width: 51)),
            ),
          ],
        ),
        body: SafeArea(child: page));
  }
}
