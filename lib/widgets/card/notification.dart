import 'package:flutter/material.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';

import 'card.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

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
            const SizedBox(width: 10),
            Icon(
              Icons.clear_rounded,
              color: HexColor('#E25C55'),
              size: 20,
            ),
          ],
        ),
        const SizedBox(height: 10),
        AppTypography(
          text:
              'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate.',
          size: 12,
          color: AppColorScheme().black70,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppTypography(
                text: '12:00 PM', size: 12, weight: FontWeight.w600),
            const SizedBox(width: 32),
            AppTypography(
                text: 'April, 08', size: 12, color: AppColorScheme().black70),
          ],
        )
      ]),
    );
  }
}
