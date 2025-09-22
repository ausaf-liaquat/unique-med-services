import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../shared/theme/color.dart';
import '../dataDisplay/typography.dart';

class AppCheckBox extends StatefulWidget {
  const AppCheckBox({
    super.key,
    required this.name,
    this.label,
    this.validator,
    this.text,
    this.enabled = true,
  });

  final String name;
  final Widget? text;
  final String? label;
  final String? Function(bool?)? validator;
  final bool enabled; // ✅ add proper enabled flag

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
      enabled: widget.enabled, // ✅ use enabled here
      decoration: const InputDecoration(
        border: InputBorder.none, // ✅ no "enabled" here
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      ),
      title: Transform.translate(
        offset: const Offset(-6, -1),
        child: widget.text ??
            AppTypography(
              text: widget.label ?? '',
              size: 16,
              weight: FontWeight.w500,
              color: AppColorScheme().black70,
            ),
      ),
      validator: widget.validator,
    );
  }
}
