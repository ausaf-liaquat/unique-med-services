import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:ums_staff/widgets/skeleton/row_item.dart';

class ShiftSkeleton extends StatelessWidget {
  const ShiftSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SkeletonParagraph(
          style: SkeletonParagraphStyle(
            padding: EdgeInsets.zero,
            lines: 1,
            lineStyle: SkeletonLineStyle(
                width: MediaQuery.of(context).size.width / 1.6,
                height: 16,
                borderRadius: BorderRadius.circular(6)),
          ),
        ),
        const SizedBox(height: 10),
        SkeletonParagraph(
          style: SkeletonParagraphStyle(
            padding: EdgeInsets.zero,
            spacing: 6,
            lines: 2,
            lineStyle: SkeletonLineStyle(
                randomLength: true,
                minLength: MediaQuery.of(context).size.width / 1.5,
                height: 12,
                borderRadius: BorderRadius.circular(6)),
          ),
        ),
        const SizedBox(height: 24),
        RowItemSkeleton(
          maxLength: MediaQuery.of(context).size.width / 2,
        ),
        const SizedBox(height: 12),
        RowItemSkeleton(
          maxLength: MediaQuery.of(context).size.width / 2,
        ),
        const SizedBox(height: 12),
        RowItemSkeleton(
          maxLength: MediaQuery.of(context).size.width / 2,
        ),
        const SizedBox(height: 12),
        RowItemSkeleton(
          minLength: MediaQuery.of(context).size.width / 1.5,
        ),
      ],
    );
  }
}
