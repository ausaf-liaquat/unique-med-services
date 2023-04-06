import 'package:flutter/material.dart';
import '../../widgets/card/calendar.dart';
import '../../widgets/card/card.dart';
import '../../widgets/dataDisplay/shift.dart';
import '../../widgets/dataDisplay/typography.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

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
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return const JobShift(accept: true);
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
