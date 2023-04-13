import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';
import '../../widgets/common/back_layout.dart';
import '../../widgets/common/check_box.dart';
import '../../widgets/dataDisplay/sub_title.dart';

class ScheduleDetailScreen extends StatelessWidget {
  const ScheduleDetailScreen({super.key});
  static const route = '/schedule/123';

  @override
  Widget build(BuildContext context) {
    bool midiumDevice = MediaQuery.of(context).size.width >= 350;
    final formKey = GlobalKey<FormBuilderState>();

    return BackLayout(
      text: 'SHIFT',
      page: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppTypography(
                        text: 'Sabal Palms Health & Rehabilitation',
                        size: 24,
                        weight: FontWeight.w500),
                    const SizedBox(height: 24),
                    const SubTitle(
                        title: 'Clocked In:',
                        subTitle: 'June 12, 2022, 06:45am',
                        bottom: 40),
                    FormBuilder(
                      key: formKey,
                      onChanged: () {
                        formKey.currentState!.save();
                      },
                      autovalidateMode: AutovalidateMode.disabled,
                      initialValue: const {
                        'break': false,
                        'forget': false,
                      },
                      skipDisabled: true,
                      child: Column(children: const [
                        AppCheckBox(
                            label: 'Took my full allotted break',
                            name: 'break'),
                        AppCheckBox(
                            label: 'Forget to clock out', name: 'forget'),
                      ]),
                    ),
                  ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed: () {},
                      child: const Text("I am being Send Home")),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {},
                      child: const Text("issues clocking out")),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          child: OutlinedButton(
                              onPressed: () {},
                              child: const Text('Offer Detail'))),
                      SizedBox(width: midiumDevice ? 32 : 15),
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('clock out'))),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
