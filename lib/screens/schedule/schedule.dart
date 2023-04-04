import 'package:flutter/material.dart';
import 'package:ums_staff/widgets/common/typography.dart';

import '../../widgets/card/calendar.dart';
import '../../widgets/card/card.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            child: Column(
              children: [
                const CalendarCard(),
                const SizedBox(height: 24),
                AppCard(
                  child: Column(
                    children: [
                      AppTypography(
                        text: 'Wednesday - August 17 ',
                        size: 20,
                        color: Theme.of(context).colorScheme.secondary,
                        weight: FontWeight.w600,
                        spacing: 0.4,
                      ),
                      const SizedBox(height: 18),
                      Divider(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                )
              ],
            )));
  }
}
