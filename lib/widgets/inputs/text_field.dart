import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';
import '../../shared/theme/color.dart';

class AppTextField extends StatefulWidget {
  const AppTextField(
      {super.key,
      required this.name,
      required this.label,
      this.validator,
      this.bottom,
      this.error,
      this.end,
      this.helpText = '',
      this.type = TextInputType.text,
      this.onTap});

  final String name;
  final void Function()? onTap;
  final String label;
  final String? Function(String?)? validator;
  final String helpText;
  final double? bottom;
  final String? error;
  final Widget? end;
  final TextInputType type;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _passwordVisible = true;

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
            maxLines: widget.type == TextInputType.multiline ? 10 : 1,
            minLines: widget.type == TextInputType.multiline ? 5 : 1,
            keyboardType: widget.type,
            name: widget.name,
            onTap: widget.onTap,
            obscureText: widget.type == TextInputType.visiblePassword
                ? _passwordVisible
                : false,
            validator: widget.validator,
            style: TextStyle(
              color: AppColorScheme().black80,
              fontSize: 16,
              letterSpacing: 0.5,
            ),
            decoration: InputDecoration(
              suffixIcon: widget.type == TextInputType.visiblePassword
                  ? Container(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconButton(
                        splashRadius: 20,
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    )
                  : widget.end,
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
