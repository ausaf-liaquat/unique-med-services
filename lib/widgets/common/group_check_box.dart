import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';

class AppGroupCheckBox extends StatefulWidget {
  const AppGroupCheckBox(
      {super.key,
      required this.name,
      this.label,
      this.validator,
      required this.options});
  final String name;
  final String? label;
  final String? Function(List<String>?)? validator;
  final List<String> options;

  @override
  State<AppGroupCheckBox> createState() => _AppGroupCheckBoxState();
}

class _AppGroupCheckBoxState extends State<AppGroupCheckBox> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderCheckboxGroup<String>(
        checkColor: Colors.white,
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
        orientation: OptionsOrientation.vertical,
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
