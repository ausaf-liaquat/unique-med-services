import 'package:flutter/material.dart';
import 'package:ums_staff/widgets/others/link.dart';

import '../../shared/theme/color.dart';
import '../../shared/utils/web_redirect.dart';
import '../card/card.dart';
import '../dataDisplay/typography.dart';

class ContactAccordion extends StatefulWidget {
  const ContactAccordion({Key? key}) : super(key: key);

  @override
  State<ContactAccordion> createState() => _ContactAccordionState();
}

class _ContactAccordionState extends State<ContactAccordion> {
  @override
  Widget build(BuildContext context) {
    return AppCard(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
              initiallyExpanded: true,
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
                AppLink(
                  onTap: () {
                    setState(() {
                      WebRedirect().supportPhoneCall(context);
                    });
                  },
                  child: const ContactItem(
                    imagePath: 'assets/images/call.png',
                    topLine: 'Call Support',
                    bottomLine: '6 AM to 10 PM MST',
                  ),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Divider()),
                AppLink(
                    onTap: () {
                      setState(() {
                        WebRedirect().supportEmail(context);
                      });
                    },
                    child: const ContactItem(
                      imagePath: 'assets/images/mail.png',
                      topLine: 'Email Support',
                      bottomLine: 'At your convenience',
                    )),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Divider()),
                const ContactItem(
                  imagePath: 'assets/images/office-address.png',
                  topLine: 'Office Address',
                  bottomLine: 'P.O. Box 3421 Riverview, FL 33568',
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
        Expanded(
            child: Column(
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
        )),
      ],
    );
  }
}
