import 'package:flutter/material.dart';

class GlassTheme extends ThemeExtension<GlassTheme> {
  final double blur;
  final double opacity;
  final double borderWidth;
  final BorderRadius borderRadius;
  final Gradient gradient;
  final Color borderColor;
  final Color tint;
  final Gradient backgroundGradient; // เพิ่ม background gradient

  const GlassTheme({
    required this.blur,
    required this.opacity,
    required this.borderWidth,
    required this.borderRadius,
    required this.gradient,
    required this.borderColor,
    required this.tint,
    required this.backgroundGradient, // เพิ่ม background gradient
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
    Gradient? backgroundGradient,
  }) {
    return GlassTheme(
      blur: blur ?? this.blur,
      opacity: opacity ?? this.opacity,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      gradient: gradient ?? this.gradient,
      borderColor: borderColor ?? this.borderColor,
      tint: tint ?? this.tint,
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
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
      backgroundGradient: _lerpGradient(backgroundGradient, other.backgroundGradient, t),
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


  // สร้าง gradient สำหรับ Light Theme
  static const Gradient _lightBackgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFF6B6B), // สีแดงสด
      Color(0xFF4ECDC4), // สีเขียวมิ้น
      Color(0xFF45B7D1), // สีฟ้าสด
      Color(0xFF96CEB4), // สีเขียวอ่อน
    ],
    stops: [0.0, 0.3, 0.7, 1.0],
  );

  // สร้าง gradient สำหรับ Dark Theme
  static const Gradient _darkBackgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF2D3748), // สีเทาเข้ม
      Color(0xFF4A5568), // สีเทาปานกลาง
      Color(0xFF2B6CB0), // สีน้ำเงินเข้ม
      Color(0xFF1A365D), // สีน้ำเงินเข้มมาก
    ],
    stops: [0.0, 0.3, 0.7, 1.0],
  );

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
        backgroundGradient: _lightBackgroundGradient, // ใช้ Light Theme gradient
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
        backgroundGradient: _darkBackgroundGradient, // ใช้ Dark Theme gradient
      );


    static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      extensions: <ThemeExtension<dynamic>>[_lightGlass],
    );

    static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo, brightness: Brightness.dark),
      scaffoldBackgroundColor: const Color(0xFF121212),
      extensions: <ThemeExtension<dynamic>>[_darkGlass],
    );
}
