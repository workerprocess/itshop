import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_app/core/themes/glass_theme.dart';

class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final bool centerTitle;
  final double? elevation;
  final PreferredSizeWidget? bottom;
  final double toolbarHeight;
  final double? leadingWidth;

  const GlassAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.centerTitle = true,
    this.elevation,
    this.bottom,
    this.toolbarHeight = kToolbarHeight,
    this.leadingWidth,
  });

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassTheme>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.zero,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: glass.blur, sigmaY: glass.blur),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: glass.gradient.scale(glass.opacity),
            border: Border(
              bottom: BorderSide(
                color: glass.borderColor,
                width: glass.borderWidth,
              ),
            ),
          ),child: AppBar(
              title: title != null 
                ? Text(
                    title!,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : null,
              leading: leading,
              actions: actions,
              automaticallyImplyLeading: automaticallyImplyLeading,
              centerTitle: centerTitle,
              elevation: 0,
              backgroundColor: Colors.transparent,
              foregroundColor: isDark ? Colors.white : Colors.black87,
              toolbarHeight: toolbarHeight,
              leadingWidth: leadingWidth,
              bottom: bottom,
            ),
          
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    toolbarHeight + (bottom?.preferredSize.height ?? 0),
  );
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
