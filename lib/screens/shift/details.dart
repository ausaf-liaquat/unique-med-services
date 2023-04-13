import 'package:flutter/material.dart';
import '../../shared/theme/color.dart';
import '../../widgets/common/back_layout.dart';
import '../../widgets/dataDisplay/sub_title.dart';
import '../../widgets/dataDisplay/typography.dart';

class ShiftDetailScreen extends StatelessWidget {
  const ShiftDetailScreen({super.key});
  static const route = '/shift/123';

  @override
  Widget build(BuildContext context) {
    bool midiumDevice = MediaQuery.of(context).size.width >= 392;
    bool smallDevice = MediaQuery.of(context).size.width >= 375;

    return BackLayout(
      text: 'Shift Offer',
      page: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppTypography(
                        text: 'Sabal Palms Health & Rehabilitation',
                        size: 24,
                        weight: FontWeight.w500),
                    const SizedBox(height: 12),
                    AppTypography(
                        text: 'Sabal Palms Health & Rehabilitation',
                        color: AppColorScheme().black60,
                        size: 17),
                    const SizedBox(height: 24),
                    const SubTitle(
                        title: 'Rate:', subTitle: '45.00/hr', bottom: 24),
                    const SubTitle(
                        title: 'Shift timing:',
                        subTitle: '06:45am - 07:15pm',
                        bottom: 24),
                    const SubTitle(
                        title: 'Shift Location:',
                        subTitle: '64 Sugar StreetYorktown Heights, NY 10598',
                        bottom: 24),
                    const SizedBox(height: 48),
                    smallDevice
                        ? Row(
                            children: [
                              Expanded(
                                  child: OutlinedButton.icon(
                                      onPressed: () {},
                                      icon:
                                          const Icon(Icons.thumb_down_rounded),
                                      label: const Text('Decline'))),
                              SizedBox(width: midiumDevice ? 32 : 15),
                              Expanded(
                                  child: ElevatedButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(Icons.thumb_up_rounded),
                                      label: const Text('Accept'))),
                            ],
                          )
                        : Row(children: [
                            Expanded(
                                child: OutlinedButton(
                                    onPressed: () {},
                                    child: const Text('Decline'))),
                            SizedBox(width: midiumDevice ? 32 : 15),
                            Expanded(
                                child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Accept'))),
                          ])
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
