import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_app/core/themes/glass_theme.dart';

class GlassFilterChip extends StatelessWidget {
  final Widget label;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  final Color? selectedColor;
  final Color? checkmarkColor;
  final EdgeInsetsGeometry? padding;
  final double? pressElevation;

  const GlassFilterChip({
    super.key,
    required this.label,
    required this.selected,
    this.onSelected,
    this.selectedColor,
    this.checkmarkColor,
    this.padding,
    this.pressElevation,
  });

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassTheme>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    // กำหนดสีสำหรับ selected state
    final effectiveSelectedColor = selectedColor ?? 
        (isDark ? Colors.white.withOpacity(0.3) : Colors.blue.withOpacity(0.3));
    
    final effectiveCheckmarkColor = checkmarkColor ?? 
        (isDark ? Colors.white.withOpacity(0.9) : Colors.blue.withOpacity(0.8));

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onSelected != null ? () => onSelected!(!selected) : null,
        borderRadius: glass.borderRadius,
        child: ClipRRect(
          borderRadius: glass.borderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: glass.blur, sigmaY: glass.blur),
            child: Container(
              padding: padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: glass.borderRadius,
                border: Border.all(
                  color: Colors.white.withOpacity(isDark ? 0.2 : 0.3),
                  width: glass.borderWidth,
                ),
                gradient: selected
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(isDark ? 0.15 : 0.25),
                          Colors.white.withOpacity(isDark ? 0.08 : 0.15),
                          Colors.white.withOpacity(isDark ? 0.03 : 0.08),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      )
                    : LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(isDark ? 0.12 : 0.20),
                          Colors.white.withOpacity(isDark ? 0.06 : 0.12),
                          Colors.white.withOpacity(isDark ? 0.02 : 0.06),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  label,
                  if (selected) ...[
                    const SizedBox(width: 6),
                    Icon(
                      Icons.check,
                      size: 16,
                      color: effectiveCheckmarkColor,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
