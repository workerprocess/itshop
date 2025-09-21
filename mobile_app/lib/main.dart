import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/core/themes/app_themes.dart';
import 'package:mobile_app/core/themes/glass_theme.dart';
import 'package:mobile_app/routes/app_pages.dart';
import 'package:mobile_app/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'IT Shop',
      theme: GlassTheme.lightTheme,
      darkTheme: GlassTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.root,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}