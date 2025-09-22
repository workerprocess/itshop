import 'package:flutter/material.dart';
import 'package:mobile_app/core/themes/glass_theme.dart';

class GlassDivider extends StatelessWidget {
  final double height;
  final double thickness;
  final double opacity;
  final EdgeInsetsGeometry? indentPadding;

  const GlassDivider({
    super.key,
    this.height = 1,
    this.thickness = 1,
    this.opacity = 1.0,
    this.indentPadding,
  });

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassTheme>()!;
    final line = Divider(
      height: height,
      thickness: thickness,
      color: glass.borderColor.withOpacity(opacity.clamp(0.0, 1.0)),
    );
    if (indentPadding != null) {
      return Padding(padding: indentPadding!, child: line);
    }
    return line;
  }
}


