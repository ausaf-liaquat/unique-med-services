import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ums_staff/screens/other/models/notification.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';

import 'card.dart';

class NotificationCard extends StatelessWidget {
  late NotificationModel notification;
  NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      radius: const BorderRadius.all(Radius.circular(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Icon(
              Icons.notifications,
              color: HexColor('#58BDEA'),
              size: 24,
            ),
            const SizedBox(width: 10),
            const Expanded(
                child: AppTypography(
              text: 'Unique med services',
              overflow: TextOverflow.ellipsis,
              size: 16,
              weight: FontWeight.w500,
            )),
          ],
        ),
        const SizedBox(height: 10),
        AppTypography(
          text:
              notification.title,
          size: 12,
          color: AppColorScheme().black70,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTypography(
                text: DateFormat('HH:mm').format(DateTime.parse(notification.createdAt)), size: 12, weight: FontWeight.w600),
            const SizedBox(width: 32),
            AppTypography(
                text: DateFormat('MMMM, dd').format(DateTime.parse(notification.createdAt)), size: 12, color: AppColorScheme().black70),
          ],
        )
      ]),
    );
  }
}
