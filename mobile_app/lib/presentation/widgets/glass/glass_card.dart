import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_app/core/themes/glass_theme.dart';

class GlassCard extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final Color? splashColor;
  final Color? highlightColor;

  const GlassCard({
    super.key,
    this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.borderRadius,
    this.onTap,
    this.splashColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassTheme>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget cardContent = ClipRRect(
      borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(12)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: glass.blur, sigmaY: glass.blur),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: glass.gradient.scale(glass.opacity),
            border: Border.all(
              color: glass.borderColor,
              width: glass.borderWidth,
            ),
            borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(12)),
          ),
          padding: padding,
          child: child,
        ),
      ),
    );

    // ถ้ามี onTap จะห่อด้วย InkWell
    if (onTap != null) {
      cardContent = InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(12)),
        splashColor: splashColor ?? Colors.white.withOpacity(0.2),
        highlightColor: highlightColor ?? Colors.white.withOpacity(0.1),
        child: cardContent,
      );
    }

    // ถ้ามี margin จะห่อด้วย Container
    if (margin != null) {
      cardContent = Container(
        margin: margin,
        child: cardContent,
      );
    }

    return cardContent;
  }
}

extension on Gradient {
  Gradient scale(double opacity) {
    if (this is LinearGradient) {
      final g = this as LinearGradient;
      return LinearGradient(
        begin: g.begin,
        end: g.end,
        stops: g.stops,
        colors: g.colors.map((c) => c.withOpacity(opacity)).toList(),
      );
    }
    return this;
  }
}
