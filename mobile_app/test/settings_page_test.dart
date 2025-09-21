import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mobile_app/presentation/bindings/settings_binding.dart';
import 'package:mobile_app/presentation/pages/settings_page.dart';

void main() {
  group('SettingsPage Navigation Tests', () {
    setUp(() {
      Get.reset();
      SettingsBinding().dependencies();
    });

    tearDown(() {
      Get.reset();
    });

    testWidgets('should navigate to settings page without null error', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        GetMaterialApp(
          home: const Scaffold(
            body: Center(
              child: Text('Test Home'),
            ),
          ),
          getPages: [
            GetPage(
              name: '/settings',
              page: () => const SettingsPage(),
              binding: SettingsBinding(),
            ),
          ],
        ),
      );

      // Act - Navigate to settings
      Get.toNamed('/settings');
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('การแสดงผล'), findsOneWidget);
      expect(find.text('การตั้งค่าแอป'), findsOneWidget);
      expect(find.text('บัญชีผู้ใช้'), findsOneWidget);
      expect(find.text('เกี่ยวกับ'), findsOneWidget);
    });

    testWidgets('should display theme toggle without error', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        GetMaterialApp(
          home: const SettingsPage(),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('ธีม'), findsOneWidget);
      expect(find.byType(Switch), findsWidgets); // Changed to findsWidgets since there are multiple switches
    });

    testWidgets('should show about dialog when tapped', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        GetMaterialApp(
          home: const SettingsPage(),
        ),
      );

      // Act
      await tester.pumpAndSettle();
      
      // Scroll to find the "เกี่ยวกับแอป" button
      await tester.scrollUntilVisible(find.text('เกี่ยวกับแอป'), 500.0);
      await tester.pumpAndSettle();
      
      // Find and tap "เกี่ยวกับแอป"
      await tester.tap(find.text('เกี่ยวกับแอป'), warnIfMissed: false);
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('เกี่ยวกับ IT Shop'), findsOneWidget);
      expect(find.text('เวอร์ชัน: 1.0.0'), findsOneWidget);
    });
  });
}
