import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ums_staff/widgets/common/typography.dart';
import '../../shared/theme/color.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.name,
    required this.label,
    this.validator,
    this.bottom,
    this.error,
    this.helpText = '',
  });

  final String name;
  final String label;
  final String? Function(String?)? validator;
  final String helpText;
  final double? bottom;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.30),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 6,
                spreadRadius: 2,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: FormBuilderTextField(
            name: name,
            validator: validator,
            style: TextStyle(
              color: AppColorScheme().black80,
              fontSize: 18,
              letterSpacing: 0.5,
            ),
            decoration: InputDecoration(
              errorStyle: const TextStyle(height: 1, fontSize: 0),
              label: AppTypography(
                text: label,
                size: 15,
                color: AppColorScheme().black50,
                spacing: 0.4,
              ),
            ),
          ),
        ),
        (helpText + (error ?? '')) != ''
            ? Container(
                margin: EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: bottom ?? 0, top: 4),
                child: AppTypography(
                  text: error ?? helpText,
                  size: 12,
                  align: TextAlign.start,
                  color: error != null
                      ? Theme.of(context).colorScheme.error
                      : AppColorScheme().black60,
                  spacing: 0.4,
                ))
            : SizedBox(
                height: bottom ?? 0,
              ),
      ],
    );
  }
}
