import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../shared/theme/color.dart';
import '../dataDisplay/typography.dart';

class AppCheckBox extends StatefulWidget {
  const AppCheckBox(
      {super.key, required this.name, required this.label, this.validator});
  final String name;
  final String label;
  final String? Function(bool?)? validator;

  @override
  State<AppCheckBox> createState() => _AppCheckBoxState();
}

class _AppCheckBoxState extends State<AppCheckBox> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderCheckbox(
        checkColor: Colors.white,
        activeColor: Theme.of(context).colorScheme.secondary,
        name: widget.name,
        initialValue: false,
        decoration: InputDecoration(
            fillColor: AppColorScheme().black2,
            enabled: false,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 0)),
        title: Transform.translate(
          offset: const Offset(-6, -1),
          child: AppTypography(
            text: widget.label,
            size: 16,
            weight: FontWeight.w500,
            color: AppColorScheme().black70,
          ),
        ),
        validator: widget.validator);
  }
}
