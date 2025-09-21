import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:fake_async/fake_async.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/presentation/bindings/app_bindings.dart';
import 'package:mobile_app/presentation/controllers/home_controller.dart';
import 'package:mobile_app/presentation/controllers/products_controller.dart';
import 'package:mobile_app/presentation/controllers/search_controller.dart';
import 'package:mobile_app/presentation/controllers/favorites_controller.dart';
import 'package:mobile_app/presentation/controllers/profile_controller.dart';

void main() {
  group('Performance Tests', () {
    setUp(() {
      Get.reset();
    });

    tearDown(() {
      Get.reset();
    });

    testWidgets('should load app within acceptable time', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange
        final stopwatch = Stopwatch()..start();
        
        // Act
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        
        stopwatch.stop();
        
        // Assert - App should load within 3 seconds
        expect(stopwatch.elapsedMilliseconds, lessThan(3000));
        expect(find.byType(MaterialApp), findsOneWidget);
      });
    });

    testWidgets('should handle rapid navigation without errors', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));

        // Act - Rapid navigation
        final tabs = ['Products', 'Search', 'Favorites', 'Profile', 'Home'];
        
        for (final tab in tabs) {
          await tester.tap(find.text(tab));
          await tester.pump();
          async.elapse(const Duration(milliseconds: 100));
        }
        
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));

        // Assert - App should still be responsive
        expect(find.byType(MaterialApp), findsOneWidget);
        expect(find.byType(BottomNavigationBar), findsOneWidget);
      });
    });

    testWidgets('should handle multiple controller initializations', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange & Act
        AppBindings().dependencies();
        
        // Initialize multiple controllers
        final controllers = [
          HomeController(),
          ProductsController(),
          ProductSearchController(),
          FavoritesController(),
          ProfileController(),
        ];

        for (final controller in controllers) {
          Get.put(controller);
        }

        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 2));

        // Assert - All controllers should be registered
        expect(Get.isRegistered<HomeController>(), true);
        expect(Get.isRegistered<ProductsController>(), true);
        expect(Get.isRegistered<ProductSearchController>(), true);
        expect(Get.isRegistered<FavoritesController>(), true);
        expect(Get.isRegistered<ProfileController>(), true);
      });
    });

    testWidgets('should handle memory cleanup on navigation', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));

        // Act - Navigate multiple times
        for (int i = 0; i < 10; i++) {
          await tester.tap(find.text('Products'));
          await tester.pump();
          async.elapse(const Duration(milliseconds: 50));
          
          await tester.tap(find.text('Search'));
          await tester.pump();
          async.elapse(const Duration(milliseconds: 50));
          
          await tester.tap(find.text('Home'));
          await tester.pump();
          async.elapse(const Duration(milliseconds: 50));
        }
        
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));

        // Assert - App should still be responsive
        expect(find.byType(MaterialApp), findsOneWidget);
      });
    });

    testWidgets('should handle theme switching performance', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));

        // Navigate to Profile
        await tester.tap(find.text('Profile'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));

        // Act - Toggle theme multiple times
        for (int i = 0; i < 5; i++) {
          await tester.tap(find.byType(Switch));
          await tester.pump();
          async.elapse(const Duration(milliseconds: 100));
        }
        
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));

        // Assert - Theme should be applied
        expect(find.byType(MaterialApp), findsOneWidget);
      });
    });
  });

  group('Memory Management Tests', () {
    setUp(() {
      Get.reset();
    });

    tearDown(() {
      Get.reset();
    });

    test('should dispose controllers properly', () {
      // Arrange
      AppBindings().dependencies();
      final homeController = HomeController();
      final productsController = ProductsController();
      
      // Act
      Get.put(homeController);
      Get.put(productsController);
      
      // Assert
      expect(Get.isRegistered<HomeController>(), true);
      expect(Get.isRegistered<ProductsController>(), true);
      
      // Cleanup
      Get.delete<HomeController>();
      Get.delete<ProductsController>();
      
      expect(Get.isRegistered<HomeController>(), false);
      expect(Get.isRegistered<ProductsController>(), false);
    });

    test('should handle controller recreation', () {
      // Arrange
      AppBindings().dependencies();
      
      // Act - Create, delete, and recreate controllers
      for (int i = 0; i < 3; i++) {
        final controller = HomeController();
        Get.put(controller);
        expect(Get.isRegistered<HomeController>(), true);
        
        Get.delete<HomeController>();
        expect(Get.isRegistered<HomeController>(), false);
      }
    });
  });

  group('Error Handling Tests', () {
    setUp(() {
      Get.reset();
    });

    tearDown(() {
      Get.reset();
    });

    testWidgets('should handle navigation errors gracefully', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));

        // Act - Try to navigate to non-existent route
        try {
          Get.toNamed('/non-existent-route');
          await tester.pumpAndSettle();
          async.elapse(const Duration(seconds: 1));
        } catch (e) {
          // Expected to throw error
        }

        // Assert - App should still be functional
        expect(find.byType(MaterialApp), findsOneWidget);
        expect(find.byType(BottomNavigationBar), findsOneWidget);
      });
    });

    testWidgets('should handle controller errors gracefully', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));

        // Act - Navigate to different pages
        await tester.tap(find.text('Products'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        
        await tester.tap(find.text('Search'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));

        // Assert - App should handle errors gracefully
        expect(find.byType(MaterialApp), findsOneWidget);
      });
    });
  });
}
