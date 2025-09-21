import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mobile_app/presentation/bindings/root_binding.dart';
import 'package:mobile_app/presentation/pages/root_page.dart';

void main() {
  group('RootPage Tests', () {
    setUp(() {
      Get.reset();
      RootBinding().dependencies();
    });

    tearDown(() {
      Get.reset();
    });

    testWidgets('should display root page with bottom navigation', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        GetMaterialApp(
          home: const RootPage(),
        ),
      );

      // Assert
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Products'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Favorites'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('should switch between tabs correctly', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        GetMaterialApp(
          home: const RootPage(),
        ),
      );

      // Act - Tap on Products tab
      await tester.tap(find.text('Products'));
      await tester.pumpAndSettle();

      // Assert - Should show Products page content
      expect(find.text('Products'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
    });

    testWidgets('should maintain state when switching tabs', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        GetMaterialApp(
          home: const RootPage(),
        ),
      );

      // Act - Switch to Products tab
      await tester.tap(find.text('Products'));
      await tester.pumpAndSettle();

      // Switch back to Home tab
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();

      // Assert - Should still show Home content
      expect(find.text('Welcome to IT Shop'), findsOneWidget);
    });
  });
}
