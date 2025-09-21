import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:fake_async/fake_async.dart';
import 'package:mobile_app/presentation/controllers/home_controller.dart';
import 'package:mobile_app/presentation/pages/home_page.dart';

void main() {
  group('HomePage Tests', () {
    setUp(() {
      Get.reset();
    });

    tearDown(() {
      Get.reset();
    });

    testWidgets('should display welcome message', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange
        Get.put<HomeController>(HomeController());
        
        await tester.pumpWidget(
          const GetMaterialApp(
            home: HomePage(),
          ),
        );

        // Act
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 2)); // Fast forward timer

        // Assert
        expect(find.text('Welcome to IT Shop'), findsOneWidget);
        expect(find.text('Your one-stop shop for IT products'), findsOneWidget);
        expect(find.byIcon(Icons.computer), findsOneWidget);
      });
    });

    testWidgets('should display bottom navigation bar', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange
        Get.put<HomeController>(HomeController());
        
        await tester.pumpWidget(
          const GetMaterialApp(
            home: HomePage(),
          ),
        );

        // Act
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 2)); // Fast forward timer

        // Assert
        expect(find.byType(BottomNavigationBar), findsOneWidget);
        expect(find.text('Home'), findsOneWidget);
        expect(find.text('Products'), findsOneWidget);
        expect(find.text('Search'), findsOneWidget);
        expect(find.text('Favorites'), findsOneWidget);
        expect(find.text('Profile'), findsOneWidget);
      });
    });
  });
}
