import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mobile_app/presentation/controllers/home_controller.dart';

void main() {
  group('HomeController Tests', () {
    setUp(() {
      Get.reset();
    });

    tearDown(() {
      Get.reset();
    });

    test('should initialize controller without errors', () {
      // Arrange & Act
      final controller = HomeController();

      // Assert
      expect(controller, isA<HomeController>());
      expect(controller.isLoading, false);
    });

    test('should load data successfully', () async {
      // Arrange
      final controller = HomeController();

      // Act
      await controller.loadData();

      // Assert
      expect(controller.isLoading, false);
    });
  });

  group('Basic Widget Tests', () {
    testWidgets('should display simple text widget', (WidgetTester tester) async {
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

    testWidgets('should display bottom navigation bar', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
              ],
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
    });
  });
}
