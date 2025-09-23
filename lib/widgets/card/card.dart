import 'package:flutter/material.dart';
import '../../shared/theme/color.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.path,
    this.radius = const BorderRadius.all(Radius.circular(20)),
    this.padding = const EdgeInsets.all(24),
    this.args,
    this.backgroundColor,
    this.borderColor,
    this.elevation = 1,
    this.shadowColor,
    this.margin,
    this.borderWidth = 0,
    this.gradient,
    this.surfaceTintColor,
    this.showSurfaceTint = false,
    this.onTap, // Add direct onTap parameter
  });

  final EdgeInsetsGeometry padding;
  final Widget child;
  final BorderRadius radius;
  final String? path;
  final dynamic args;
  final Color? backgroundColor;
  final Color? borderColor;
  final double elevation;
  final Color? shadowColor;
  final EdgeInsetsGeometry? margin;
  final double borderWidth;
  final Gradient? gradient;
  final Color? surfaceTintColor;
  final bool showSurfaceTint;
  final VoidCallback? onTap; // New onTap parameter

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final cardContent = Container(
      margin: margin ?? const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: gradient != null ? null : backgroundColor ?? colorScheme.surface,
        gradient: gradient,
        borderRadius: radius,
        border: borderWidth > 0 ? Border.all(
          color: borderColor ?? colorScheme.outline.withOpacity(0.2),
          width: borderWidth,
        ) : null,
        boxShadow: _buildBoxShadows(context),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: radius,
          onTap: onTap ?? (path != null ? () {
            Navigator.pushNamed(context, path!, arguments: args ?? {});
          } : null),
          splashColor: surfaceTintColor?.withOpacity(0.1) ?? colorScheme.primary.withOpacity(0.1),
          highlightColor: Colors.transparent,
          child: Container(
            padding: padding,
            decoration: showSurfaceTint ? BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  (surfaceTintColor ?? colorScheme.primary).withOpacity(0.03),
                  Colors.transparent,
                ],
              ),
            ) : null,
            child: child,
          ),
        ),
      ),
    );

    return cardContent;
  }

  List<BoxShadow> _buildBoxShadows(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (elevation <= 0) return [];

    if (isDark) {
      return [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 8 * elevation,
          offset: Offset(0, 2 * elevation),
          spreadRadius: 0.5 * elevation,
        ),
      ];
    }

    return [
      BoxShadow(
        color: shadowColor ?? Colors.black.withOpacity(0.05 * elevation),
        blurRadius: 12 * elevation,
        offset: Offset(0, 4 * elevation),
        spreadRadius: -2 * elevation,
      ),
      BoxShadow(
        color: shadowColor ?? Colors.black.withOpacity(0.1 * elevation),
        blurRadius: 6 * elevation,
        offset: Offset(0, 1 * elevation),
        spreadRadius: -1 * elevation,
      ),
    ];
  }
}

class ModernCard {
  static Widget elevated({
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.all(24),
    BorderRadius radius = const BorderRadius.all(Radius.circular(20)),
    Color? backgroundColor,
    double elevation = 2,
    VoidCallback? onTap,
  }) {
    return AppCard(
      padding: padding,
      radius: radius,
      backgroundColor: backgroundColor,
      elevation: elevation,
      onTap: onTap, // Use the new onTap parameter instead of path
      child: child,
    );
  }
}