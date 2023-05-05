import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ums_staff/screens/shift/models.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/widgets/dataDisplay/row_item.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';
class JobShift extends StatelessWidget {
  late ShiftModel shift;
  JobShift({super.key, this.accept = false, required this.shift});
  final bool accept;

  @override
  Widget build(BuildContext context) {
    var shiftNote = [];
    if( shift.shiftNote != '' ){
      shiftNote = (jsonDecode(shift.shiftNote.toString()) as List<dynamic>).map((e) => e.toString()).toList();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTypography(
          text: shift.title,
          size: 18,
          weight: FontWeight.w600,
          color: AppColorScheme().black90,
        ),
        const SizedBox(height: 4),
        AppTypography(
          text: shiftNote.join(', '),
          size: 14,
          weight: FontWeight.w500,
          color: AppColorScheme().black60,
        ),
        const SizedBox(height: 24),
        RowItem(
          icon: Icons.attach_money_rounded,
          text: shift.ratePerHour,
        ),
        RowItem(
          icon: Icons.calendar_month_outlined,
          text: shift.date,
        ),
        RowItem(
          icon: Icons.access_time,
          text: shift.shiftHour,
        ),
        RowItem(
          icon: Icons.location_on_outlined,
          text: shift.shiftLocation,
        ),
        // accept ? const SizedBox(height: 24) : const SizedBox(),
        // accept
        //     ? SizedBox(
        //         width: 135,
        //         child: ElevatedButton.icon(
        //             onPressed: () {},
        //             style: ButtonStyle(
        //                 elevation: MaterialStateProperty.all(0),
        //                 backgroundColor:
        //                     MaterialStateProperty.all(HexColor('#E25C55'))),
        //             icon: const Icon(Icons.block_outlined),
        //             label: const Text('Call Out')),
        //       )
        //     : const SizedBox()
      ],
    );
  }
}
