import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';

import '../../shared/theme/color.dart';

class AppSwitch extends StatefulWidget {
  const AppSwitch(
      {super.key,
      required this.title,
      this.subTitle,
      required this.name,
      this.validator});
  final String title;
  final String? subTitle;
  final String? Function(bool?)? validator;
  final String name;

  @override
  State<AppSwitch> createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: FormBuilderSwitch(
        decoration: const InputDecoration(
            enabled: false,
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 0)),
        validator: widget.validator,
        activeColor: Theme.of(context).colorScheme.secondary,
        title: AppTypography(
            text: widget.title,
            size: 16,
            spacing: 0.05,
            weight: FontWeight.w500,
            color: AppColorScheme().black80),
        subtitle: AppTypography(
          text: widget.subTitle ?? '',
          size: 12,
          spacing: 0.05,
          weight: FontWeight.w500,
          color: AppColorScheme().black60,
        ),
        name: widget.name,
      ),
    );
  }
}
