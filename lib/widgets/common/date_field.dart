import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';
import '../../shared/theme/color.dart';

class AppDateField extends StatefulWidget {
  const AppDateField(
      {super.key,
      required this.name,
      required this.label,
      this.validator,
      this.bottom,
      this.error,
      this.end = const SizedBox(),
      this.helpText = '',
      this.type = TextInputType.text,
      this.onTap});

  final String name;
  final void Function()? onTap;
  final String label;
  final String? Function(DateTime?)? validator;
  final String helpText;
  final double? bottom;
  final String? error;
  final Widget end;
  final TextInputType type;

  @override
  State<AppDateField> createState() => _AppDateFieldState();
}

class _AppDateFieldState extends State<AppDateField> {
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
          child: FormBuilderDateTimePicker(
            name: widget.name,
            validator: widget.validator,
            initialEntryMode: DatePickerEntryMode.calendarOnly,
            inputType: InputType.date,
            transitionBuilder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: HexColor('#2AABE4'),
                    onPrimary: HexColor('#FFFFFF'),
                    onSurface: AppColorScheme().black90,
                  ),
                ),
                child: child!,
              );
            },
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.date_range_outlined,
                  color: AppColorScheme().black50),
              errorStyle: const TextStyle(height: 1, fontSize: 0),
              label: AppTypography(
                text: widget.label,
                size: 15,
                color: AppColorScheme().black50,
                spacing: 0.4,
              ),
            ),
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
