import 'package:flutter/material.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/widgets/card/card.dart';
import 'package:ums_staff/widgets/dataDisplay/row_item.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';

class DocumentCard extends StatelessWidget {
  const DocumentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
        padding: const EdgeInsets.only(right: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 75,
                height: 75,
                child: Image.asset(
                  'assets/test/licence.png',
                  fit: BoxFit.cover,
                )),
            const SizedBox(width: 24),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                AppTypography(
                  align: TextAlign.start,
                  text: 'Nursing Licensef.',
                  overflow: TextOverflow.ellipsis,
                  size: 18,
                  color: AppColorScheme().black90,
                  weight: FontWeight.w500,
                ),
                const SizedBox(height: 8),
                RowItem(
                  icon: Icons.auto_delete_outlined,
                  text: 'Apr 30, 2023',
                  textColor: AppColorScheme().black60,
                  iconColor: Theme.of(context).colorScheme.error,
                )
              ],
            )),
            const SizedBox(width: 8),
            Icon(
              Icons.verified,
              color: HexColor('#3CA442'),
              size: 24,
            )
          ],
        ));
  }
}
