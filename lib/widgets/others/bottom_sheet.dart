import 'package:flutter/material.dart';
import 'package:ums_staff/widgets/others/link.dart';
import 'package:ums_staff/widgets/dataDisplay/row_item.dart';

import '../../screens/other/BCA_form/emplotment_bca_form.dart';
import '../../screens/other/direct_deposit.dart';
import '../../screens/other/notification.dart';
import '../../screens/other/support.dart';
import '../../screens/other/w9_form/w9_form.dart';
import '../../shared/theme/color.dart';

class ProfileBottomSheet extends StatelessWidget {
  const ProfileBottomSheet({super.key});

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
              return Container(
                height: 500,
                padding: const EdgeInsets.fromLTRB(30, 68, 30, 0),
                child: Column(
                  children: [
                    AppLink(
                        path: W9FormScreen.route,
                        child: const RowItem(
                            large: true,
                            bottom: 32,
                            icon: Icons.feed_outlined,
                            text: 'W9 Form')),
                    AppLink(
                        path: EmplotmentFormScreen.route,
                        child: const RowItem(
                            large: true,
                            bottom: 32,
                            icon: Icons.feed_outlined,
                            text: 'Employee BCA Form')),
                    AppLink(
                        path: DirectDepositScreen.route,
                        child: const RowItem(
                            large: true,
                            bottom: 32,
                            icon: Icons.feed_outlined,
                            text: 'Deposit Form')),
                    AppLink(
                        path: NotificationScreen.route,
                        child: const RowItem(
                            large: true,
                            bottom: 32,
                            icon: Icons.notifications_outlined,
                            text: 'Notification')),
                    AppLink(
                        path: SupportScreen.route,
                        child: const RowItem(
                            large: true,
                            bottom: 32,
                            icon: Icons.support_agent_outlined,
                            text: 'Help')),
                    // RowItem(
                    //     large: true,
                    //     bottom: 30,
                    //     icon: Icons.article_outlined,
                    //     text: 'Privacy Policy'),
                    // RowItem(
                    //     large: true,
                    //     bottom: 30,
                    //     icon: Icons.gavel_outlined,
                    //     text: 'Terms & Conditions')
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
