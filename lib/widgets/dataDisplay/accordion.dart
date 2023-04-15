import 'package:flutter/material.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/widgets/card/card.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';

class AppAccordion extends StatelessWidget {
  const AppAccordion({super.key, required this.title, this.text, this.item});
  final String title;
  final String? text;
  final Widget? item;

  @override
  Widget build(BuildContext context) {
    return AppCard(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
              tilePadding: const EdgeInsets.all(0),
              collapsedIconColor: Theme.of(context).colorScheme.secondary,
              title: AppTypography(
                text: title,
                height: 1.5,
                size: 16,
                weight: FontWeight.w500,
                color: AppColorScheme().black80,
              ), //header title
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 4),
                  child: item ??
                      AppTypography(
                        text: text ?? "",
                        size: 13,
                        color: AppColorScheme().black50,
                      ),
                ),
              ]),
        ));
  }
}
