import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';
import '../../shared/theme/color.dart';

class AppSelectField extends StatefulWidget {
  const AppSelectField({
    super.key,
    required this.name,
    required this.label,
    this.validator,
    required this.title,
    this.bottom,
    this.error,
    this.helpText = '',
    required this.onSelect,
    required this.option,
  });

  final String name;
  final String title;
  final String label;
  final String? Function(String?)? validator;
  final void Function(String, String) onSelect;
  final String helpText;
  final double? bottom;
  final String? error;
  final List<String> option;

  @override
  State<AppSelectField> createState() => _AppSelectFieldState();
}

class _AppSelectFieldState extends State<AppSelectField> {
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
            readOnly: true,
            name: widget.name,
            validator: widget.validator,
            style: TextStyle(
              color: AppColorScheme().black80,
              fontSize: 16,
              letterSpacing: 0.5,
            ),
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.arrow_drop_down_outlined,
                  color: AppColorScheme().black50),
              errorStyle: const TextStyle(height: 1, fontSize: 0),
              label: AppTypography(
                text: widget.label,
                size: 15,
                color: AppColorScheme().black50,
                spacing: 0.4,
              ),
            ),
            onTap: () {
              showCupertinoModalPopup<void>(
                context: context,
                builder: (BuildContext context) => CupertinoActionSheet(
                    message: AppTypography(
                      text: widget.title,
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
                    actions: widget.option.map((String item) {
                      return CupertinoActionSheetAction(
                        isDestructiveAction: true,
                        onPressed: () {
                          widget.onSelect(widget.name, item);
                          Navigator.pop(context, item);
                        },
                        child: AppTypography(
                          text: item,
                          align: TextAlign.center,
                          size: 20,
                          spacing: 0.38,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      );
                    }).toList()),
              );
            },
          ),
        ),
        (widget.helpText + (widget.error ?? '')) != ''
            ? Container(
                margin: EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: widget.bottom ?? 0,
                    top: 4),
                child: AppTypography(
                  text: widget.error ?? widget.helpText,
                  size: 12,
                  align: TextAlign.start,
                  color: widget.error != null
                      ? Theme.of(context).colorScheme.error
                      : AppColorScheme().black60,
                  spacing: 0.4,
                ))
            : SizedBox(
                height: widget.bottom ?? 0,
              ),
      ],
    );
  }
}
