import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class RowItemSkeleton extends StatelessWidget {
  const RowItemSkeleton({Key? key, this.minLength, this.maxLength}) : super(key: key);
  final double? minLength;
  final double? maxLength;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SkeletonAvatar(style: SkeletonAvatarStyle(width: 18, height: 18)),
        const SizedBox(width: 10),
        Expanded(
          child: SkeletonParagraph(
            style: SkeletonParagraphStyle(
              padding: EdgeInsets.zero,
              lines: 1,
              lineStyle: SkeletonLineStyle(
                  randomLength: true,
                  minLength: minLength,
                  maxLength: maxLength,
                  height: 12,
                  borderRadius: BorderRadius.circular(6)),
            ),
          ),
        ),
      ],
    );
  }
}
