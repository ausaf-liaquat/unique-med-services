import 'package:flutter/material.dart';
import 'package:ums_staff/widgets/dataDisplay/row_item.dart';

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
                height: 314,
                padding: const EdgeInsets.fromLTRB(30, 68, 30, 0),
                child: Column(
                  children: const [
                    RowItem(
                        large: true,
                        bottom: 32,
                        icon: Icons.notifications_outlined,
                        text: 'Notification'),
                    RowItem(
                        large: true,
                        bottom: 32,
                        icon: Icons.support_agent_outlined,
                        text: 'Help'),
                    RowItem(
                        large: true,
                        bottom: 32,
                        icon: Icons.article_outlined,
                        text: 'Privacy Policy'),
                    RowItem(
                        large: true,
                        bottom: 32,
                        icon: Icons.gavel_outlined,
                        text: 'Terms & Conditions')
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
