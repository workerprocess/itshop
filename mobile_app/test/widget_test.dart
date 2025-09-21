import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/presentation/bindings/home_binding.dart';
import 'package:mobile_app/presentation/pages/home_page.dart';

void main() {
  group('HomePage Widget Tests', () {
    setUp(() {
      Get.reset();
    });

    tearDown(() {
      Get.reset();
    });

    testWidgets('should display welcome message', (WidgetTester tester) async {
      // Arrange
      Get.put(HomeBinding());
      await tester.pumpWidget(const GetMaterialApp(home: HomePage()));

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Welcome to IT Shop'), findsOneWidget);
      expect(find.text('Your one-stop shop for IT products'), findsOneWidget);
      expect(find.byIcon(Icons.computer), findsOneWidget);
    });

    testWidgets('should navigate to settings when settings icon is tapped',
        (WidgetTester tester) async {
      // Arrange
      Get.put(HomeBinding());
      await tester.pumpWidget(const GetMaterialApp(home: HomePage()));

      // Act
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('should display bottom navigation bar', (WidgetTester tester) async {
      // Arrange
      Get.put(HomeBinding());
      await tester.pumpWidget(const GetMaterialApp(home: HomePage()));

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Products'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Favorites'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });
  });

  group('App Integration Tests', () {
    setUp(() {
      Get.reset();
    });

    tearDown(() {
      Get.reset();
    });

    testWidgets('should load main app without errors', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.text('IT Shop'), findsOneWidget);
    });
  });
}