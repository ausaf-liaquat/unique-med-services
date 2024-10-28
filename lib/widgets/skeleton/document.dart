import 'package:flutter/material.dart';
import 'package:flutter_skeleton_plus/flutter_skeleton_plus.dart';
import 'package:ums_staff/widgets/skeleton/row_item.dart';

import '../card/card.dart';

class DocumentSkeleton extends StatelessWidget {
  const DocumentSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCard(
        padding: const EdgeInsets.only(right: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
                child: SkeletonAvatar(style: SkeletonAvatarStyle(width: 75, height: 75, borderRadius: BorderRadius.zero))),
            const SizedBox(width: 24),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SkeletonParagraph(
                  style: SkeletonParagraphStyle(
                    padding: EdgeInsets.zero,
                    lines: 1,
                    lineStyle: SkeletonLineStyle(randomLength: true, width: MediaQuery.of(context).size.width / 2, height: 16, borderRadius: BorderRadius.circular(6)),
                  ),
                ),
                const SizedBox(height: 8),
                RowItemSkeleton(
                  maxLength: MediaQuery.of(context).size.width / 3,
                ),
              ],
            )),
            const SizedBox(width: 8),
            const SkeletonAvatar(style: SkeletonAvatarStyle(width: 18, height: 18))
          ],
        ));
  }
}
