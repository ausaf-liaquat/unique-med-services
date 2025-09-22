import 'package:flutter/material.dart';
import 'package:ums_staff/shared/utils/web_redirect.dart';
import 'package:ums_staff/widgets/others/link.dart';
import 'package:ums_staff/widgets/dataDisplay/row_item.dart';

import '../../screens/other/BCA_form/emplotment_bca_form.dart';
import '../../screens/other/direct_deposit.dart';
import '../../screens/other/notification.dart';
import '../../screens/other/support.dart';
import '../../screens/other/w9_form/w9_form.dart';
import '../../shared/theme/color.dart';

class ProfileBottomSheet extends StatefulWidget {
  const ProfileBottomSheet({Key? key}) : super(key: key);

  @override
  State<ProfileBottomSheet> createState() => _ProfileBottomSheetState();
}

class _ProfileBottomSheetState extends State<ProfileBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: const Icon(Icons.more_horiz),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            backgroundColor: AppColorScheme().black0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28), topRight: Radius.circular(28)),
            ),
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Container(
                  height: 900,
                  padding: const EdgeInsets.fromLTRB(30, 68, 30, 0),
                  child: Column(
                    children: [
                      AppLink(
                          pop: true,
                          path: W9FormScreen.route,
                          child: const RowItem(
                              large: true,
                              bottom: 32,
                              icon: Icons.feed_outlined,
                              text: 'W9 Form')),
                      AppLink(
                          pop: true,
                          path: EmplotmentFormScreen.route,
                          child: const RowItem(
                              large: true,
                              bottom: 32,
                              icon: Icons.feed_outlined,
                              text: 'Employee BCA Form')),
                      AppLink(
                          pop: true,
                          path: DirectDepositScreen.route,
                          child: const RowItem(
                              large: true,
                              bottom: 32,
                              icon: Icons.feed_outlined,
                              text: 'Deposit Form')),
                      AppLink(
                          onTap: () {
                            setState(() {
                              WebRedirect().physicalForm(context);
                              Navigator.pop(context);
                            });
                          },
                          child: const RowItem(
                              large: true,
                              bottom: 32,
                              icon: Icons.feed_outlined,
                              text: 'Physical Form')),
                      AppLink(
                          onTap: () {
                            setState(() {
                              WebRedirect().annualForm(context);
                              Navigator.pop(context);
                            });
                          },
                          child: const RowItem(
                              large: true,
                              bottom: 32,
                              icon: Icons.feed_outlined,
                              text: 'Annual Physical Form')),
                      AppLink(
                          onTap: () {
                            setState(() {
                              WebRedirect().testForm(context);
                              Navigator.pop(context);
                            });
                          },
                          child: const RowItem(
                              large: true,
                              bottom: 32,
                              icon: Icons.feed_outlined,
                              text: 'TB Test Result Form')),
                      AppLink(
                          onTap: () {
                            setState(() {
                              WebRedirect().timeSlip(context);
                              Navigator.pop(context);
                            });
                          },
                          child: const RowItem(
                              large: true,
                              bottom: 32,
                              icon: Icons.feed_outlined,
                              text: 'Timeslip')),
                      AppLink(
                          pop: true,
                          path: NotificationScreen.route,
                          child: const RowItem(
                              large: true,
                              bottom: 32,
                              icon: Icons.notifications_outlined,
                              text: 'Notification')),
                      AppLink(
                          pop: true,
                          path: SupportScreen.route,
                          child: const RowItem(
                              large: true,
                              bottom: 32,
                              icon: Icons.support_agent_outlined,
                              text: 'Help')),
                      AppLink(
                          onTap: () {
                            setState(() {
                              WebRedirect().privacyPolicy(context);
                              Navigator.pop(context);
                            });
                          },
                          child: const RowItem(
                              large: true,
                              bottom: 30,
                              icon: Icons.article_outlined,
                              text: 'Privacy Policy')),
                      AppLink(
                          onTap: () {
                            setState(() {
                              WebRedirect().termsAndConditions(context);
                              Navigator.pop(context);
                            });
                          },
                          child: const RowItem(
                              large: true,
                              bottom: 30,
                              icon: Icons.gavel_outlined,
                              text: 'Terms & Conditions'))
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
