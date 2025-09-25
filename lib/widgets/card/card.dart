import 'dart:ui'; // Add this import for ImageFilter
import 'package:flutter/material.dart';
import '../../shared/theme/color.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.path,
    this.args,

    // Layout
    this.padding = const EdgeInsets.all(24),
    this.margin,
    this.radius = const BorderRadius.all(Radius.circular(24)),
    this.constraints,
    this.height,
    this.width,

    // Background & Border
    this.backgroundColor,
    this.gradient,
    this.borderColor,
    this.borderWidth = 0,
    this.borderGradient,

    // Shadow & Elevation
    this.elevation = 1,
    this.shadowColor,
    this.shadowBlurRadius,
    this.shadowSpreadRadius,

    // Visual Effects
    this.surfaceTintColor,
    this.showSurfaceTint = true,
    this.backgroundBlendMode,
    this.backgroundImage,

    // Animation
    this.animationDuration = const Duration(milliseconds: 200),
    this.scaleFactor = 0.98,
    this.enableHoverEffect = true,

    // Interactive States
    this.splashColor,
    this.highlightColor,
    this.hoverColor,
    this.enabled = true,
  });

  final Widget child;
  final VoidCallback? onTap;
  final String? path;
  final dynamic args;

  // Layout
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius radius;
  final BoxConstraints? constraints;
  final double? height;
  final double? width;

  // Background & Border
  final Color? backgroundColor;
  final Gradient? gradient;
  final Color? borderColor;
  final double borderWidth;
  final Gradient? borderGradient;

  // Shadow & Elevation
  final double elevation;
  final Color? shadowColor;
  final double? shadowBlurRadius;
  final double? shadowSpreadRadius;

  // Visual Effects
  final Color? surfaceTintColor;
  final bool showSurfaceTint;
  final BlendMode? backgroundBlendMode;
  final DecorationImage? backgroundImage;

  // Animation
  final Duration animationDuration;
  final double scaleFactor;
  final bool enableHoverEffect;

  // Interactive States
  final Color? splashColor;
  final Color? highlightColor;
  final Color? hoverColor;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme; // Fixed: Now properly defined
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedContainer(
      duration: animationDuration,
      margin: margin ?? const EdgeInsets.only(bottom: 16),
      constraints: constraints,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: enabled
            ? (gradient != null ? null : backgroundColor ?? theme.colorScheme.surfaceContainerLow)
            : theme.colorScheme.onSurface.withOpacity(0.12),
        gradient: enabled ? gradient : null,
        borderRadius: radius,
        border: _buildBorder(theme.colorScheme), // Fixed: Use theme.colorScheme
        boxShadow: _buildBoxShadows(context),
        image: backgroundImage,
        backgroundBlendMode: backgroundBlendMode,
      ),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: radius,
        child: _buildInkWell(context),
      ),
    );
  }

  Border? _buildBorder(ColorScheme colorScheme) {
    if (borderWidth <= 0) return null;

    if (borderGradient != null) {
      return Border.fromBorderSide(
        BorderSide(
          width: borderWidth,
          style: BorderStyle.solid,
        ),
      );
    }

    return Border.all(
      color: borderColor ?? colorScheme.outline.withOpacity(0.3),
      width: borderWidth,
    );
  }

  Widget _buildInkWell(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (!enabled) {
      return Container(
        padding: padding,
        child: Opacity(
          opacity: 0.38,
          child: child,
        ),
      );
    }

    return InkWell(
      borderRadius: radius,
      onTap: onTap ?? (path != null ? () {
        Navigator.pushNamed(context, path!, arguments: args ?? {});
      } : null),
      splashColor: splashColor ?? surfaceTintColor?.withOpacity(0.1) ?? colorScheme.primary.withOpacity(0.1),
      highlightColor: highlightColor ?? Colors.transparent,
      hoverColor: hoverColor ?? colorScheme.primary.withOpacity(0.05),
      onHover: enableHoverEffect ? (hovering) {} : null,
      child: AnimatedContainer(
        duration: animationDuration,
        padding: padding,
        decoration: showSurfaceTint ? BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              (surfaceTintColor ?? colorScheme.primary).withOpacity(0.02),
              Colors.transparent,
            ],
          ),
          borderRadius: radius,
        ) : null,
        child: MouseRegion(
          cursor: (onTap != null || path != null) && enabled
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,
          child: child,
        ),
      ),
    );
  }

  List<BoxShadow> _buildBoxShadows(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme; // Fixed: Define colorScheme here
    final isDark = theme.brightness == Brightness.dark;

    if (elevation <= 0) return [];

    final blurRadius = shadowBlurRadius ?? (isDark ? 8 * elevation : 16 * elevation);
    final spreadRadius = shadowSpreadRadius ?? (isDark ? 0.5 * elevation : -4 * elevation);

    if (isDark) {
      return [
        BoxShadow(
          color: shadowColor ?? Colors.black.withOpacity(0.4 * elevation),
          blurRadius: blurRadius,
          offset: Offset(0, 3 * elevation),
          spreadRadius: spreadRadius,
        ),
      ];
    }

    return [
      // Soft background shadow
      BoxShadow(
        color: shadowColor ?? colorScheme.shadow.withOpacity(0.08 * elevation),
        blurRadius: blurRadius * 1.5,
        offset: Offset(0, 6 * elevation),
        spreadRadius: spreadRadius,
      ),
      // Sharp foreground shadow
      BoxShadow(
        color: shadowColor ?? colorScheme.shadow.withOpacity(0.12 * elevation),
        blurRadius: blurRadius * 0.5,
        offset: Offset(0, 1 * elevation),
        spreadRadius: spreadRadius * 0.5,
      ),
    ];
  }
}

class ModernCard {
  // Modern elevated card with Material 3 design
  static Widget elevated({
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.all(24),
    BorderRadius radius = const BorderRadius.all(Radius.circular(24)),
    Color? backgroundColor,
    double elevation = 2,
    VoidCallback? onTap,
    bool enabled = true,
    EdgeInsetsGeometry? margin,
  }) {
    return AppCard(
      padding: padding,
      radius: radius,
      backgroundColor: backgroundColor,
      elevation: elevation,
      onTap: onTap,
      enabled: enabled,
      margin: margin,
      showSurfaceTint: true,
      child: child,
    );
  }

  // Glass morphism card for modern UI
  static Widget glass({
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.all(24),
    BorderRadius radius = const BorderRadius.all(Radius.circular(24)),
    double blurStrength = 12,
    double opacity = 0.08,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Stack(
        children: [
          // Background blur
          Container(
            decoration: BoxDecoration(
              borderRadius: radius,
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(opacity),
                  Colors.white.withOpacity(opacity * 0.6),
                ],
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blurStrength, sigmaY: blurStrength), // Fixed: ImageFilter now imported
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: radius,
                ),
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: radius,
                    onTap: onTap,
                    splashColor: Colors.white.withOpacity(0.1),
                    highlightColor: Colors.transparent,
                    child: Container(
                      padding: padding,
                      child: child,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Gradient card for vibrant designs
  static Widget gradient({
    required Widget child,
    required Gradient gradient,
    EdgeInsetsGeometry padding = const EdgeInsets.all(24),
    BorderRadius radius = const BorderRadius.all(Radius.circular(24)),
    double elevation = 1,
    VoidCallback? onTap,
    bool enabled = true,
  }) {
    return AppCard(
      padding: padding,
      radius: radius,
      gradient: gradient,
      elevation: elevation,
      onTap: onTap,
      enabled: enabled,
      borderWidth: 0,
      child: child,
    );
  }

  // Outline card with thin border
  static Widget outlined({
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.all(24),
    BorderRadius radius = const BorderRadius.all(Radius.circular(16)),
    Color? borderColor,
    Color? backgroundColor,
    double borderWidth = 1,
    VoidCallback? onTap,
    bool enabled = true,
  }) {
    return AppCard(
      padding: padding,
      radius: radius,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      elevation: 0,
      onTap: onTap,
      enabled: enabled,
      child: child,
    );
  }

  // Filled card with strong background
  static Widget filled({
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.all(24),
    BorderRadius radius = const BorderRadius.all(Radius.circular(20)),
    Color? backgroundColor,
    VoidCallback? onTap,
    bool enabled = true,
  }) {
    return AppCard(
      padding: padding,
      radius: radius,
      backgroundColor: backgroundColor ?? Colors.blue.withOpacity(0.1),
      elevation: 0,
      onTap: onTap,
      enabled: enabled,
      borderWidth: 0,
      showSurfaceTint: false,
      child: child,
    );
  }

  // Compact card for dense layouts
  static Widget compact({
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16),
    BorderRadius radius = const BorderRadius.all(Radius.circular(16)),
    Color? backgroundColor,
    double elevation = 1,
    VoidCallback? onTap,
    bool enabled = true,
  }) {
    return AppCard(
      padding: padding,
      radius: radius,
      backgroundColor: backgroundColor,
      elevation: elevation,
      onTap: onTap,
      enabled: enabled,
      margin: const EdgeInsets.only(bottom: 12),
      child: child,
    );
  }
}

// Pre-defined gradient presets
class CardGradients {
  static Gradient get bluePurple => LinearGradient(
    colors: [Colors.blue.shade100, Colors.purple.shade100],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static Gradient get orangePink => LinearGradient(
    colors: [Colors.orange.shade100, Colors.pink.shade100],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static Gradient get greenTeal => LinearGradient(
    colors: [Colors.green.shade100, Colors.teal.shade100],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static Gradient get surfaceGradient => LinearGradient(
    colors: [
      Colors.grey.shade50,
      Colors.grey.shade100,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// Extension for easy customization
extension AppCardExtensions on AppCard {
  AppCard copyWith({
    Widget? child,
    VoidCallback? onTap,
    String? path,
    dynamic args,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BorderRadius? radius,
    Color? backgroundColor,
    Gradient? gradient,
    Color? borderColor,
    double? borderWidth,
    double? elevation,
    Color? shadowColor,
    Color? surfaceTintColor,
    bool? showSurfaceTint,
  }) {
    return AppCard(
      child: child ?? this.child,
      onTap: onTap ?? this.onTap,
      path: path ?? this.path,
      args: args ?? this.args,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      radius: radius ?? this.radius,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      gradient: gradient ?? this.gradient,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      elevation: elevation ?? this.elevation,
      shadowColor: shadowColor ?? this.shadowColor,
      surfaceTintColor: surfaceTintColor ?? this.surfaceTintColor,
      showSurfaceTint: showSurfaceTint ?? this.showSurfaceTint,
    );
  }
}