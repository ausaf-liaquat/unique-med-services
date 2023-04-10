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
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28), topRight: Radius.circular(28)),
            ),
            builder: (BuildContext context) {
              return Container(
                height: 320,
                padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
                child: Column(
                  children: const [
                    RowItem(
                        large: true,
                        icon: Icons.notifications_outlined,
                        text: 'Notification'),
                    SizedBox(height: 26),
                    RowItem(
                        large: true,
                        icon: Icons.support_agent_outlined,
                        text: 'Help'),
                    SizedBox(height: 26),
                    RowItem(
                        large: true,
                        icon: Icons.article_outlined,
                        text: 'Privacy Policy'),
                    SizedBox(height: 26),
                    RowItem(
                        large: true,
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
