import 'package:flutter/material.dart';
import 'package:ums_staff/widgets/card/card.dart';

import '../../shared/theme/color.dart';
import '../dataDisplay/row_item.dart';
import '../dataDisplay/typography.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
        radius: BorderRadius.circular(35),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.all(4),
                    height: 150,
                    width: 96,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColorScheme().black0,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 6,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/test/profile.jpg',
                        fit: BoxFit.cover,
                      ),
                    )),
                const SizedBox(width: 19),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        const AppTypography(
                          overflow: TextOverflow.ellipsis,
                          text: 'Cornelia Selvan',
                          size: 20,
                          weight: FontWeight.w500,
                        ),
                        const SizedBox(height: 4),
                        AppTypography(
                          overflow: TextOverflow.ellipsis,
                          text: 'Plumber',
                          size: 15,
                          color: AppColorScheme().black50,
                          weight: FontWeight.w500,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          ProfileShiftData(
                              quentity: '24', title: 'Assigned Shifts'),
                          SizedBox(width: 13),
                          ProfileShiftData(
                              quentity: '56', title: 'Complete Shifts'),
                          SizedBox(width: 13),
                          ProfileShiftData(
                              quentity: '27', title: 'UnComplete Shifts'),
                        ],
                      ),
                    )
                  ],
                ))
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(12, 24, 12, 0),
              child: Column(
                children: [
                  const RowItem(
                    icon: Icons.call_outlined,
                    text: '7274631685',
                    bottom: 16,
                  ),
                  const RowItem(
                      icon: Icons.location_on_outlined,
                      bottom: 16,
                      text: 'uvsoffl@gmail.co'),
                  const RowItem(
                      icon: Icons.call_outlined,
                      bottom: 16,
                      text: '11929 Bahia Valley Drive'),
                  Row(
                    children: const [
                      Expanded(
                          child: RowItem(
                              icon: Icons.apartment_outlined,
                              bottom: 16,
                              text: 'Riverview')),
                      SizedBox(width: 6),
                      Expanded(
                          child: RowItem(
                        icon: Icons.villa_outlined,
                        text: 'FL',
                        bottom: 16,
                      ))
                    ],
                  ),
                  const RowItem(
                    icon: Icons.map_outlined,
                    text: '33579',
                    bottom: 16,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class ProfileShiftData extends StatelessWidget {
  const ProfileShiftData(
      {super.key, required this.title, required this.quentity});
  final String title;
  final String quentity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: HexColor('#F1FAFD'),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          AppTypography(text: quentity, size: 18, weight: FontWeight.w500),
          const SizedBox(height: 4),
          AppTypography(
              align: TextAlign.center,
              text: title,
              size: 14,
              weight: FontWeight.w500)
        ],
      ),
    );
  }
}
