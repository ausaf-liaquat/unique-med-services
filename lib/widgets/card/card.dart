import 'package:flutter/material.dart';
import '../../shared/theme/color.dart';

class AppCard extends StatelessWidget {
  const AppCard(
      {super.key,
      required this.child,
      this.path,
      this.radius,
      this.padding = const EdgeInsets.all(20)});

  final EdgeInsetsGeometry padding;
  final Widget child;
  final BorderRadiusGeometry? radius;
  final String? path;

  @override
  Widget build(BuildContext context) {
    return path != null
        ? InkWell(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              path == null ? () {} : Navigator.pushNamed(context, path ?? '');
            },
            child: Container(
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
            ),
          )
        : Container(
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
