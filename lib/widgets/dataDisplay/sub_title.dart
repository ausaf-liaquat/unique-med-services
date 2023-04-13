import 'package:flutter/material.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';

class SubTitle extends StatelessWidget {
  const SubTitle(
      {super.key, required this.title, required this.subTitle, this.bottom});
  final String title;
  final double? bottom;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTypography(text: title, size: 16, weight: FontWeight.w500),
        const SizedBox(height: 6),
        AppTypography(
          text: subTitle,
          size: 14,
          weight: FontWeight.w500,
          color: AppColorScheme().black60,
        ),
        SizedBox(height: bottom),
      ],
    );
  }
}
