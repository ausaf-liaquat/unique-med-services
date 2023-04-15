import 'package:flutter/material.dart';

import '../../shared/theme/color.dart';
import '../card/card.dart';
import '../dataDisplay/typography.dart';

class ContactAccordion extends StatelessWidget {
  const ContactAccordion({super.key});

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
                text: "Didn't find what you were looking for?",
                height: 1.5,
                size: 16,
                weight: FontWeight.w500,
                color: AppColorScheme().black80,
              ), //header title
              children: [
                const SizedBox(height: 12),
                const ContactItem(
                  imagePath: 'assets/images/message.png',
                  topLine: 'Chat With Support',
                  bottomLine: 'For most quick answers and help',
                ),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Divider()),
                const ContactItem(
                  imagePath: 'assets/images/mail.png',
                  topLine: 'Email Support',
                  bottomLine: 'At your convenience',
                ),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Divider()),
                const ContactItem(
                  imagePath: 'assets/images/call.png',
                  topLine: 'Call Support',
                  bottomLine: '6 AM to 10 PM MST',
                ),
              ]),
        ));
  }
}

class ContactItem extends StatelessWidget {
  const ContactItem(
      {super.key,
      required this.imagePath,
      required this.topLine,
      required this.bottomLine});
  final String imagePath;
  final String topLine;
  final String bottomLine;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 75,
          width: 75,
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
        const SizedBox(width: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTypography(text: topLine, size: 18, weight: FontWeight.w500),
            const SizedBox(height: 8),
            AppTypography(
              text: bottomLine,
              size: 14,
              color: AppColorScheme().black60,
            ),
          ],
        )
      ],
    );
  }
}
