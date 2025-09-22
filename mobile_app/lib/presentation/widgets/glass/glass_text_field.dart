import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_app/core/themes/glass_theme.dart';

class GlassTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool obscureText;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? padding;
  final double? height;

  const GlassTextField({
    super.key,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.obscureText = false,
    this.keyboardType,
    this.padding,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassTheme>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: height ?? 50,
      decoration: BoxDecoration(
        borderRadius: glass.borderRadius,
        border: Border.all(
          color: Colors.white.withOpacity(isDark ? 0.2 : 0.3),
          width: glass.borderWidth,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.1 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: glass.borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: glass.blur * 0.8, sigmaY: glass.blur * 0.8),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
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
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onTap: onTap,
              readOnly: readOnly,
              obscureText: obscureText,
              keyboardType: keyboardType,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: isDark ? Colors.white.withOpacity(0.6) : Colors.grey[600],
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                prefixIcon: prefixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.all(12),
                        child: prefixIcon,
                      )
                    : null,
                suffixIcon: suffixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.all(12),
                        child: suffixIcon,
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: padding ?? const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                filled: false,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
