import 'package:flutter/material.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';
import '../../shared/theme/color.dart';

class RowItem extends StatelessWidget {
  const RowItem(
      {super.key,
      required this.icon,
      this.iconColor,
      required this.text,
      this.large = false,
      this.bottom = 12,
      this.textColor});
  final IconData icon;
  final Color? iconColor;
  final String text;
  final Color? textColor;
  final bool large;
  final double bottom;

  @override
  Widget build(BuildContext context) {
    return large
        ? Container(
            padding: EdgeInsets.only(bottom: bottom),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: iconColor ?? AppColorScheme().black70,
                  size: 24,
                ),
                const SizedBox(width: 18),
                AppTypography(
                  text: text,
                  spacing: 0.4,
                  size: 16,
                  weight: FontWeight.w500,
                  color: textColor ?? AppColorScheme().black90,
                ),
              ],
            ),
          )
        : Container(
            padding: EdgeInsets.only(bottom: bottom),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: iconColor ?? Theme.of(context).colorScheme.secondary,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AppTypography(
                    text: text,
                    spacing: 0.4,
                    size: 15,
                    weight: FontWeight.w500,
                    color: textColor ?? AppColorScheme().black80,
                  ),
                )
              ],
            ),
          );
  }
}
