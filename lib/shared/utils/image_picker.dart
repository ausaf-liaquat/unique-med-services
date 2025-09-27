import 'dart:io';

import 'package:file_picker/file_picker.dart';
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

  static void pickerFile(BuildContext context, Function(File) onFilePicked) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'jpg', 'jpeg', 'png', 'gif'],
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        File file = File(result.files.single.path!);
        onFilePicked(file);
      }
    } catch (e) {
      print("File picking error: $e");
    }
  }
}
