import 'package:flutter/material.dart';
import 'package:flutter_skeleton_plus/flutter_skeleton_plus.dart';
import 'package:ums_staff/widgets/skeleton/row_item.dart';

import '../../shared/theme/color.dart';
import '../card/card.dart';

class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({Key? key}) : super(key: key);

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
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColorScheme().black0, boxShadow: <BoxShadow>[
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
                        child: const SkeletonAvatar(style: SkeletonAvatarStyle(width: 88, height: 142, borderRadius: BorderRadius.zero)))),
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
                        SkeletonParagraph(
                          style: SkeletonParagraphStyle(
                            padding: EdgeInsets.zero,
                            lines: 1,
                            lineStyle: SkeletonLineStyle(randomLength: true, width: MediaQuery.of(context).size.width / 3, height: 15, borderRadius: BorderRadius.circular(6)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SkeletonAvatar(style: SkeletonAvatarStyle(width: 90, height: 95, borderRadius: BorderRadius.all(Radius.circular(22)))),
                          SizedBox(width: 13),
                          SkeletonAvatar(style: SkeletonAvatarStyle(width: 90, height: 95, borderRadius: BorderRadius.all(Radius.circular(22)))),
                          SizedBox(width: 13),
                          SkeletonAvatar(style: SkeletonAvatarStyle(width: 90, height: 95, borderRadius: BorderRadius.all(Radius.circular(22)))),
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
                  RowItemSkeleton(
                    maxLength: MediaQuery.of(context).size.width / 1.5,
                  ),
                  const SizedBox(height: 16),
                  RowItemSkeleton(
                    maxLength: MediaQuery.of(context).size.width / 1.5,
                  ),
                  const SizedBox(height: 16),
                  RowItemSkeleton(
                    maxLength: MediaQuery.of(context).size.width / 2,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: RowItemSkeleton(
                          maxLength: MediaQuery.of(context).size.width / 3,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: RowItemSkeleton(
                          maxLength: MediaQuery.of(context).size.width / 4,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  RowItemSkeleton(
                    maxLength: MediaQuery.of(context).size.width / 2,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
