import 'package:flutter/material.dart';
import '../../shared/theme/color.dart';

class AppCard extends StatelessWidget {
  const AppCard(
      {super.key,
      required this.child,
      this.radius,
      this.padding = const EdgeInsets.all(20)});

  final EdgeInsetsGeometry padding;
  final Widget child;
  final BorderRadiusGeometry? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColorScheme().black0,
        borderRadius: radius ?? BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 6,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
