import 'package:flutter/material.dart';

import '../../shared/theme/color.dart';
import '../../widgets/card/profile.dart';
import '../../widgets/dataDisplay/typography.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool midiumDevice = MediaQuery.of(context).size.width >= 392;
    bool smallDevice = MediaQuery.of(context).size.width >= 375;

    return Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const ProfileCard(),
                  const SizedBox(height: 32),
                  smallDevice
                      ? Row(
                          children: [
                            Expanded(
                                child: OutlinedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit_outlined),
                                    label: const Text('PROFILE'))),
                            SizedBox(width: midiumDevice ? 32 : 15),
                            Expanded(
                                child: ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.logout_outlined),
                                    label: const Text('LOG OUT'))),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                                child: OutlinedButton(
                                    onPressed: () {},
                                    child: const Text('PROFILE'))),
                            SizedBox(width: midiumDevice ? 32 : 15),
                            Expanded(
                                child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('LOG OUT'))),
                          ],
                        ),
                  const SizedBox(height: 24),
                ],
              ),
            )),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: AppTypography(
                  text: 'Account Deletion Policy',
                  size: 12,
                  weight: FontWeight.w500,
                  spacing: 0.1,
                  color: HexColor('#6505A3'),
                )),
                const AppTypography(
                  text: 'Version: ',
                  size: 12,
                  weight: FontWeight.w500,
                  spacing: 0.1,
                ),
                const AppTypography(
                  text: '1.16.102',
                  size: 12,
                  weight: FontWeight.w600,
                  spacing: 0.1,
                )
              ],
            )
          ],
        ));
  }
}
