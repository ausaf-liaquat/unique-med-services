import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/widgets/card/card.dart';

import '../dataDisplay/typography.dart';

class UploadFileCard extends StatefulWidget {
  const UploadFileCard({super.key, this.file, this.useImage});
  final File? file;
  final bool? useImage;

  @override
  State<UploadFileCard> createState() => _UploadFileCardState();
}

class _UploadFileCardState extends State<UploadFileCard> {

  @override
  Widget build(BuildContext context) {
    var size =( (widget.file?.lengthSync() ??1) / 100000).round();
    return AppCard(
        radius: BorderRadius.circular(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.useImage == true ? SizedBox(
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius:
                  BorderRadius.circular(100),
                  child: Image.file(
                    widget.file!,
                    fit: BoxFit.cover,
                  ),
                )) : const SizedBox(),
            SizedBox(width: widget.useImage == true ? 24 : 0),
            Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    AppTypography(
                      text: widget.file?.path ?? '',
                      size: 14,
                      color: AppColorScheme().black70,
                    ),
                    const SizedBox(height: 6),
                    AppTypography(
                      text:
                      '${size} MB',
                      size: 18,
                      weight: FontWeight.w500,
                    ),
                  ],
                ))
          ],
        ));
  }
}