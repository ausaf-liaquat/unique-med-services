import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';

class AppGroupRadioBox extends StatefulWidget {
  const AppGroupRadioBox(
      {super.key,
      required this.name,
      this.label,
      this.validator,
      this.onchange,
      required this.options,
      this.direction = OptionsOrientation.vertical});
  final String name;
  final OptionsOrientation direction;
  final String? label;
  final String? Function(String?)? validator;
  final void Function(String?)? onchange;
  final List<String> options;

  @override
  State<AppGroupRadioBox> createState() => _AppGroupRadioBoxState();
}

class _AppGroupRadioBoxState extends State<AppGroupRadioBox> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderRadioGroup<String>(
        onChanged: widget.onchange,
        activeColor: Theme.of(context).colorScheme.secondary,
        name: widget.name,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 4),
          errorStyle: TextStyle(
              fontSize: 12,
              height: 0,
              letterSpacing: 0.04,
              color: Theme.of(context).colorScheme.error),
          labelText: widget.label,
          fillColor: AppColorScheme().black2,
          enabled: false,
        ),
        orientation: widget.direction,
        options: widget.options.map((Object item) {
          return FormBuilderFieldOption(
            value: item as String,
            child: AppTypography(
              text: item,
              size: 14,
              color: AppColorScheme().black60,
            ),
          );
        }).toList(),
        validator: widget.validator);
  }
}
