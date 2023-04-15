import 'package:flutter/material.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/widgets/dataDisplay/list_item.dart';

import '../../widgets/common/back_layout.dart';
import '../../widgets/common/search_field.dart';
import '../shared/utils/initial_data.dart';
import '../widgets/dataDisplay/accordion.dart';
import '../widgets/dataDisplay/typography.dart';
import '../widgets/others/contact_accordion.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});
  static const route = '/support';

  @override
  Widget build(BuildContext context) {
    return BackLayout(
      text: 'Help',
      page: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
            child: const SearchField(),
          ),
          Image.asset(
            'assets/images/support.png',
            fit: BoxFit.fitWidth,
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
              child: Column(
                children: [
                  AppAccordion(
                    title:
                        'Why is my account frozen and why cant I request a shift?',
                    item: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTypography(
                          text: "Automatic a frozen ",
                          size: 13,
                          color: AppColorScheme().black50,
                        ),
                        const SizedBox(height: 2),
                        ListItem(
                          text: ' No call no show',
                          bottom: 2,
                          listNumber: '●',
                          color: AppColorScheme().black50,
                          size: 13,
                        ),
                        ListItem(
                          text: ' Cancel less then 2 hours in advance',
                          bottom: 2,
                          listNumber: '●',
                          color: AppColorScheme().black50,
                          size: 13,
                        ),
                        ListItem(
                          text: ' Inactivity ',
                          bottom: 2,
                          listNumber: '●',
                          color: AppColorScheme().black50,
                          size: 13,
                        ),
                        ListItem(
                          text: ' Investigation',
                          bottom: 2,
                          listNumber: '●',
                          color: AppColorScheme().black50,
                          size: 13,
                        )
                      ],
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: const Divider()),
                  ListView.separated(
                    itemCount: AppInitialData().frequentAskQuestion.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return AppAccordion(
                          title: AppInitialData().frequentAskQuestion[index]
                              ['title'],
                          text: AppInitialData().frequentAskQuestion[index]
                              ['text']);
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: const Divider()),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: const Divider()),
                  const ContactAccordion()
                ],
              )),
        ],
      )),
    );
  }
}
