import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/dataDisplay/typography.dart';
import '../theme/color.dart';

class ImagePick {
  static void pickerImage(BuildContext context, void Function(File) onTap) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
                message: AppTypography(
                  text: 'Select Image Source?',
                  align: TextAlign.center,
                  size: 13,
                  spacing: -0.08,
                  color: AppColorScheme().black50,
                ),
                cancelButton: CupertinoActionSheetAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                  child: AppTypography(
                    text: 'Cancel',
                    size: 20,
                    weight: FontWeight.w600,
                    spacing: 0.38,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                actions: [
                  CupertinoActionSheetAction(
                    isDestructiveAction: true,
                    onPressed: () async {
                      Navigator.pop(context, 'Camera');
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      if (image == null) {
                        return;
                      }
                      onTap(File(image.path));
                    },
                    child: AppTypography(
                      text: 'Camera',
                      size: 20,
                      spacing: 0.38,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  CupertinoActionSheetAction(
                    isDestructiveAction: true,
                    onPressed: () async {
                      Navigator.pop(context, 'Gallery');
                      final image =  await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (image == null) {
                        return;
                      }
                      onTap(File(image.path));
                    },
                    child: AppTypography(
                      text: 'Gallery',
                      size: 20,
                      spacing: 0.38,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ]));
  }
}
