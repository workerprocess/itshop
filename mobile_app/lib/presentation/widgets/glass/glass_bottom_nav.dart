import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:mobile_app/core/themes/glass_theme.dart';

class GlassBottomNav extends StatelessWidget {
  final BottomNavigationBarType type;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavigationBarItem> items;

  const GlassBottomNav({
    super.key,
    required this.type,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassTheme>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: glass.blur, sigmaY: glass.blur),
        child: Container(
          decoration: BoxDecoration(
            gradient: glass.gradient.scale(glass.opacity),
            border: Border(top: BorderSide(color: glass.borderColor, width: glass.borderWidth)),
          ),
          // child: SafeArea(
            // top: false,
            child: BottomNavigationBar(
              type: type,
              currentIndex: currentIndex,
              onTap: onTap,
              backgroundColor: Colors.transparent,
              elevation: 0,
              // type: BottomNavigationBarType.fixed,
              selectedItemColor: isDark ? Colors.white : Colors.black87,
              unselectedItemColor: (isDark ? Colors.white70 : Colors.black54),
              items: items,
            ),
          // ),
        ),
      ),
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
