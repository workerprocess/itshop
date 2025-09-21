import 'package:flutter/material.dart';

class GlassTheme extends ThemeExtension<GlassTheme> {
  final double blur;
  final double opacity;
  final double borderWidth;
  final BorderRadius borderRadius;
  final Gradient gradient;
  final Color borderColor;
  final Color tint;

  const GlassTheme({
    required this.blur,
    required this.opacity,
    required this.borderWidth,
    required this.borderRadius,
    required this.gradient,
    required this.borderColor,
    required this.tint,
  });

  @override
  GlassTheme copyWith({
    double? blur,
    double? opacity,
    double? borderWidth,
    BorderRadius? borderRadius,
    Gradient? gradient,
    Color? borderColor,
    Color? tint,
  }) {
    return GlassTheme(
      blur: blur ?? this.blur,
      opacity: opacity ?? this.opacity,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      gradient: gradient ?? this.gradient,
      borderColor: borderColor ?? this.borderColor,
      tint: tint ?? this.tint,
    );
  }

  @override
  ThemeExtension<GlassTheme> lerp(ThemeExtension<GlassTheme>? other, double t) {
    if (other is! GlassTheme) return this;
    return GlassTheme(
      blur: blur + (other.blur - blur) * t,
      opacity: opacity + (other.opacity - opacity) * t,
      borderWidth: borderWidth + (other.borderWidth - borderWidth) * t,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      gradient: _lerpGradient(gradient, other.gradient, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      tint: Color.lerp(tint, other.tint, t)!,
    );
  }

  static Gradient _lerpGradient(Gradient a, Gradient b, double t) {
    if (a is LinearGradient && b is LinearGradient) {
      return LinearGradient(
        begin: Alignment.lerp(a.begin as Alignment, b.begin as Alignment, t)!,
        end: Alignment.lerp(a.end as Alignment, b.end as Alignment, t)!,
        colors: List.generate(a.colors.length,
            (i) => Color.lerp(a.colors[i], b.colors[i], t)!),
        stops: a.stops,
      );
    }
    return t < 0.5 ? a : b;
  }


  static GlassTheme get _lightGlass => GlassTheme(
        blur: 20,
        opacity: 0.20,
        borderWidth: 1.2,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white.withOpacity(0.35), Colors.white.withOpacity(0.10)],
        ),
        borderColor: Colors.white.withOpacity(0.28),
        tint: const Color(0x55FFFFFF),
      );

  static GlassTheme get _darkGlass => GlassTheme(
        blur: 24,
        opacity: 0.16,
        borderWidth: 1.2,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white.withOpacity(0.18), Colors.white.withOpacity(0.06)],
        ),
        borderColor: Colors.white.withOpacity(0.22),
        tint: const Color(0x33FFFFFF),
      );


    static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      scaffoldBackgroundColor: const Color(0xFFEFF3F7),
      extensions: <ThemeExtension<dynamic>>[_lightGlass],
    );

    static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo, brightness: Brightness.dark),
      scaffoldBackgroundColor: const Color(0xFF0E1116),
      extensions: <ThemeExtension<dynamic>>[_darkGlass],
    );
}
