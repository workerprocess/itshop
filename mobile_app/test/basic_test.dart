import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mobile_app/core/themes/app_themes.dart';

void main() {
  group('App Theme Tests', () {
    testWidgets('should load light theme without errors', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        GetMaterialApp(
          theme: AppThemes.lightTheme,
          home: const Scaffold(
            body: Center(
              child: Text('Test App'),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Test App'), findsOneWidget);
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('should load dark theme without errors', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        GetMaterialApp(
          darkTheme: AppThemes.darkTheme,
          themeMode: ThemeMode.dark,
          home: const Scaffold(
            body: Center(
              child: Text('Test App'),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Test App'), findsOneWidget);
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });

  group('Basic Widget Tests', () {
    testWidgets('should display simple widget', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: Text('Hello World'),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Hello World'), findsOneWidget);
    });
  });
}
