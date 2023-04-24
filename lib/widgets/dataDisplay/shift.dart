import 'package:flutter/material.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/widgets/dataDisplay/row_item.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';

import '../messages/snack_bar.dart';

class JobShift extends StatelessWidget {
  const JobShift({super.key, this.accept = false});
  final bool accept;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTypography(
          text: 'Sabal Palms Health & Rehabilitation',
          size: 18,
          weight: FontWeight.w600,
          color: AppColorScheme().black90,
        ),
        const SizedBox(height: 4),
        AppTypography(
          text: "Peds/Young Adults. Preferred experience in g-tubes and trachs",
          size: 14,
          weight: FontWeight.w500,
          color: AppColorScheme().black60,
        ),
        const SizedBox(height: 24),
        const RowItem(
          icon: Icons.attach_money_rounded,
          text: '45.00/hr',
        ),
        const RowItem(
          icon: Icons.calendar_month_outlined,
          text: 'Monday, June 12, 2022 ',
        ),
        const RowItem(
          icon: Icons.access_time,
          text: '06:45am - 07:15pm',
        ),
        const RowItem(
          icon: Icons.location_on_outlined,
          text: '64 Sugar StreetYorktown Heights, NY 10598',
        ),
        accept ? const SizedBox(height: 24) : const SizedBox(),
        accept
            ? SizedBox(
                width: 135,
                child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor:
                            MaterialStateProperty.all(HexColor('#E25C55'))),
                    icon: const Icon(Icons.block_outlined),
                    label: const Text('Call Out')),
              )
            : const SizedBox()
      ],
    );
  }
}
