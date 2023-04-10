import 'package:flutter/material.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';

import '../../shared/theme/color.dart';

class Payout extends StatelessWidget {
  const Payout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: AppTypography(
                    text: 'Sabal Palms Health',
                    overflow: TextOverflow.ellipsis,
                    size: 17,
                    weight: FontWeight.w500,
                    color: AppColorScheme().black80,
                    spacing: 0.37)),
            const SizedBox(width: 8),
            AppTypography(
                text: '\$200.15',
                size: 17,
                weight: FontWeight.w600,
                color: AppColorScheme().black80,
                spacing: 0.37)
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: AppTypography(
                    text: 'Monday, June 12, 2022 ',
                    overflow: TextOverflow.ellipsis,
                    size: 15,
                    color: AppColorScheme().black50,
                    spacing: 0.44)),
            const SizedBox(width: 8),
            AppTypography(
                text: '5:30',
                size: 15,
                color: Theme.of(context).colorScheme.secondary,
                spacing: 0.44)
          ],
        )
      ],
    );
  }
}
