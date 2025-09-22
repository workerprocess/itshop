import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_app/core/themes/glass_theme.dart';

class GlassContainer extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final bool frosted;

  const GlassContainer({
    super.key,
    this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.borderRadius,
    this.frosted = true,
  });

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassTheme>()!;

    Widget content = ClipRRect(
      borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(12)),
      child: frosted
          ? BackdropFilter(
              filter: ImageFilter.blur(sigmaX: glass.blur, sigmaY: glass.blur),
              child: _buildContainer(glass),
            )
          : _buildContainer(glass),
    );

    if (margin != null) {
      content = Container(margin: margin, child: content);
    }

    return content;
  }

  Widget _buildContainer(GlassTheme glass) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: glass.gradient.scale(glass.opacity),
        border: Border.all(color: glass.borderColor, width: glass.borderWidth),
        borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(12)),
      ),
      padding: padding,
      child: child,
    );
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


