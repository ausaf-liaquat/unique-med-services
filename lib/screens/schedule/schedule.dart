import 'package:flutter/material.dart';
import 'package:ums_staff/widgets/common/typography.dart';

import '../../widgets/card/calendar.dart';
import '../../widgets/card/card.dart';
import '../../widgets/card/shift.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    const data = ['a', 'b', 'c', 'd'];

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
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Divider(
                              color: Theme.of(context).colorScheme.secondary)),
                      ListView.separated(
                        itemCount: data.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return const JobShift();
                          // for dinamic usage: data[index].value
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: const Divider()),
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}
