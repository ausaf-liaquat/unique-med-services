import 'package:flutter/material.dart';
import 'package:ums_staff/widgets/card/card.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';

import '../../shared/theme/color.dart';

class PayoutDetailCard extends StatelessWidget {
  const PayoutDetailCard({super.key});

  @override
  Widget build(BuildContext context) {
    bool smallDevice = MediaQuery.of(context).size.width >= 350;

    return AppCard(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTypography(
                      text:
                          smallDevice ? 'Total Shift Payment' : 'Total Payment',
                      size: 20,
                      color: AppColorScheme().black60,
                    ),
                    const SizedBox(height: 4),
                    const AppTypography(
                      text: '\$550.56',
                      weight: FontWeight.w500,
                      size: 32,
                    ),
                  ],
                ),
                Chip(
                  backgroundColor: HexColor('#3CA442'),
                  label: AppTypography(
                    text: 'Clear',
                    size: 14,
                    weight: FontWeight.w600,
                    spacing: 0.44,
                    color: AppColorScheme().black0,
                  ),
                )
              ],
            ),
            const SizedBox(height: 24),
            AppTypography(
              text: 'RATE PER HOUR',
              size: 14,
              color: AppColorScheme().black60,
            ),
            const SizedBox(height: 4),
            AppTypography(
              text: '\$59.58',
              weight: FontWeight.w500,
              size: 18,
              color: HexColor('#8406D5'),
            ),
            const SizedBox(height: 24),
            AppTypography(
              text: 'HOURS WORKED',
              size: 14,
              color: AppColorScheme().black60,
            ),
            const SizedBox(height: 4),
            AppTypography(
              text: '5:30 Hours',
              weight: FontWeight.w500,
              size: 18,
              color: HexColor('#2AABE4'),
            ),
            const SizedBox(height: 24),
            AppTypography(
              text:
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
              size: 14,
              color: AppColorScheme().black50,
            ),
          ],
        ));
  }
}
