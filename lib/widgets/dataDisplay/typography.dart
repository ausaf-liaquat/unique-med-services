
import 'package:flutter/material.dart';
import '../../shared/theme/color.dart';

class AppTypography extends StatelessWidget {
  const AppTypography(
      {Key? key,
      required this.text,
      required this.size,
      this.weight = FontWeight.normal,
      this.spacing,
      this.height,
      this.color,
      this.align = TextAlign.start})
      : super(key: key);

  final String text;
  final double size;
  final FontWeight weight;
  final double? spacing;
  final double? height;
  final Color? color;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent, // <-- Add this, if needed
        child: Text(
          text,
          style: TextStyle(
            fontSize: size,
            fontWeight: weight,
            letterSpacing: spacing,
            height: height,
            color: color ?? AppColorScheme().black90,
          ),
          textAlign: align,
        ));
  }
}
