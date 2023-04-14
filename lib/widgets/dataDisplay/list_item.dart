import 'package:flutter/material.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';

class ListItem extends StatelessWidget {
  const ListItem(
      {super.key, required this.text, required this.listNumber, this.bottom});
  final String text;
  final String listNumber;
  final double? bottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: bottom ?? 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTypography(
            text: listNumber,
            size: 14,
            color: AppColorScheme().black60,
          ),
          const SizedBox(width: 4),
          Expanded(
              child: AppTypography(
            text: text,
            size: 14,
            color: AppColorScheme().black60,
          ))
        ],
      ),
    );
  }
}
