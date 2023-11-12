import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:ums_staff/widgets/card/card.dart';

import '../../screens/profile/model.dart';
import '../../shared/theme/color.dart';
import '../../shared/utils/image_picker.dart';
import '../dataDisplay/row_item.dart';
import '../dataDisplay/typography.dart';

class ProfileCard extends StatelessWidget {
  Profile? profile;
  ProfileCard({super.key, required this.profile});

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
                      child: Container(
                          color: AppColorScheme().black6,
                          child: Image.asset(
                            'assets/images/defult-profile.jpg',
                            fit: BoxFit.cover,
                          )
                          // profile?.imageUrl != null
                          //     ? CachedNetworkImage(
                          //         placeholder: (context, url) =>
                          //             const SkeletonAvatar(
                          //           style: SkeletonAvatarStyle(
                          //               width: 88,
                          //               height: 142,
                          //               borderRadius: BorderRadius.zero),
                          //         ),
                          //         fit: BoxFit.cover,
                          //         imageUrl: profile?.imageUrl ?? '',
                          //       )
                          //     :
                          // Image.asset(
                          //         'assets/images/default-profile.jpg',
                          //         fit: BoxFit.cover,
                          //       ),
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
                        AppTypography(
                          overflow: TextOverflow.ellipsis,
                          text:
                              '${profile?.firstName ?? ''} ${profile?.lastName ?? ''}',
                          size: 20,
                          weight: FontWeight.w500,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfileShiftData(
                              quentity: ((profile?.completedShifts ?? 0) +
                                      (profile?.unCompletedShifts ?? 0))
                                  .toString(),
                              title: 'Assigned Shifts'),
                          const SizedBox(width: 13),
                          ProfileShiftData(
                              quentity:
                                  (profile?.completedShifts ?? 0).toString(),
                              title: 'Complete Shifts'),
                          const SizedBox(width: 13),
                          ProfileShiftData(
                              quentity:
                                  (profile?.unCompletedShifts ?? 0).toString(),
                              title: 'UnComplete Shifts'),
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
                  RowItem(
                    icon: Icons.call_outlined,
                    text: '+123456789',
                    bottom: 16,
                  ),
                  RowItem(
                      icon: Icons.location_on_outlined,
                      bottom: 16,
                      text: '132, My Street, Kingston, New York'),
                  RowItem(
                      icon: Icons.call_outlined,
                      bottom: 16,
                      text: '+123456789'),
                  Row(
                    children: [
                      Expanded(
                          child: RowItem(
                              icon: Icons.apartment_outlined,
                              bottom: 16,
                              text: 'USA')),
                      SizedBox(width: 6),
                      Expanded(
                          child: RowItem(
                        icon: Icons.villa_outlined,
                        text: 'New York',
                        bottom: 16,
                      ))
                    ],
                  ),
                  RowItem(
                    icon: Icons.map_outlined,
                    text: '12401',
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
