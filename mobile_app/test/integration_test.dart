import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:fake_async/fake_async.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/presentation/bindings/app_bindings.dart';
import 'package:mobile_app/presentation/bindings/home_binding.dart';
import 'package:mobile_app/presentation/bindings/products_binding.dart';
import 'package:mobile_app/presentation/bindings/search_binding.dart';
import 'package:mobile_app/presentation/bindings/favorites_binding.dart';
import 'package:mobile_app/presentation/bindings/profile_binding.dart';
import 'package:mobile_app/routes/app_routes.dart';
import 'package:mobile_app/core/network/api_client.dart';
import 'package:mobile_app/data/datasources/product_data_source.dart';
import 'package:mobile_app/domain/repositories/product_repository.dart';
import 'package:mobile_app/presentation/controllers/home_controller.dart';
import 'package:mobile_app/presentation/controllers/products_controller.dart';
import 'package:mobile_app/presentation/controllers/search_controller.dart';
import 'package:mobile_app/presentation/controllers/favorites_controller.dart';
import 'package:mobile_app/presentation/controllers/profile_controller.dart';

void main() {
  group('App Integration Tests', () {
    setUp(() {
      Get.reset();
    });

    tearDown(() {
      Get.reset();
    });

    testWidgets('should load main app without errors', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange & Act
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 2));

        // Assert
        expect(find.byType(MaterialApp), findsOneWidget);
        expect(find.text('IT Shop'), findsOneWidget);
      });
    });

    testWidgets('should navigate between all tabs', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 2));

        // Test Home Tab
        expect(find.text('Home'), findsOneWidget);
        expect(find.text('Welcome to IT Shop'), findsOneWidget);

        // Navigate to Products
        await tester.tap(find.text('Products'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Products'), findsOneWidget);

        // Navigate to Search
        await tester.tap(find.text('Search'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Search'), findsOneWidget);

        // Navigate to Favorites
        await tester.tap(find.text('Favorites'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Favorites'), findsOneWidget);

        // Navigate to Profile
        await tester.tap(find.text('Profile'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Profile'), findsOneWidget);

        // Navigate back to Home
        await tester.tap(find.text('Home'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Welcome to IT Shop'), findsOneWidget);
      });
    });

    testWidgets('should display bottom navigation bar on all pages', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 2));

        // Test all tabs
        final tabs = ['Home', 'Products', 'Search', 'Favorites', 'Profile'];
        
        for (final tab in tabs) {
          await tester.tap(find.text(tab));
          await tester.pumpAndSettle();
          async.elapse(const Duration(seconds: 1));
          
          // Assert bottom navigation is present
          expect(find.byType(BottomNavigationBar), findsOneWidget);
          expect(find.text('Home'), findsOneWidget);
          expect(find.text('Products'), findsOneWidget);
          expect(find.text('Search'), findsOneWidget);
          expect(find.text('Favorites'), findsOneWidget);
          expect(find.text('Profile'), findsOneWidget);
        }
      });
    });

    testWidgets('should handle app bar actions', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 2));

        // Test settings button on Home page
        await tester.tap(find.byIcon(Icons.settings));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Settings'), findsOneWidget);

        // Navigate back
        await tester.tap(find.byIcon(Icons.arrow_back));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Welcome to IT Shop'), findsOneWidget);
      });
    });

    testWidgets('should maintain state across navigation', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 2));

        // Navigate to Products and verify it loads
        await tester.tap(find.text('Products'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Products'), findsOneWidget);

        // Navigate to Search
        await tester.tap(find.text('Search'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Search'), findsOneWidget);

        // Navigate back to Products
        await tester.tap(find.text('Products'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Products'), findsOneWidget);
      });
    });
  });

  group('Binding Integration Tests', () {
    setUp(() {
      Get.reset();
    });

    tearDown(() {
      Get.reset();
    });

    test('should initialize app bindings without errors', () {
      // Arrange & Act
      AppBindings().dependencies();

      // Assert - Check that core dependencies are registered
      expect(Get.isRegistered<ApiClient>(), true);
      expect(Get.isRegistered<ProductDataSource>(), true);
      expect(Get.isRegistered<ProductRepository>(), true);
    });

    test('should initialize home binding without errors', () {
      // Arrange & Act
      HomeBinding().dependencies();

      // Assert
      expect(Get.isRegistered<HomeController>(), true);
    });

    test('should initialize products binding without errors', () {
      // Arrange & Act
      ProductsBinding().dependencies();

      // Assert
      expect(Get.isRegistered<ProductsController>(), true);
    });

    test('should initialize search binding without errors', () {
      // Arrange & Act
      SearchBinding().dependencies();

      // Assert
      expect(Get.isRegistered<ProductSearchController>(), true);
    });

    test('should initialize favorites binding without errors', () {
      // Arrange & Act
      FavoritesBinding().dependencies();

      // Assert
      expect(Get.isRegistered<FavoritesController>(), true);
    });

    test('should initialize profile binding without errors', () {
      // Arrange & Act
      ProfileBinding().dependencies();

      // Assert
      expect(Get.isRegistered<ProfileController>(), true);
    });
  });

  group('Route Integration Tests', () {
    setUp(() {
      Get.reset();
    });

    tearDown(() {
      Get.reset();
    });

    testWidgets('should navigate to all routes', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 2));

        // Test route navigation
        Get.toNamed(AppRoutes.products);
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Products'), findsOneWidget);

        Get.toNamed(AppRoutes.search);
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Search'), findsOneWidget);

        Get.toNamed(AppRoutes.favorites);
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Favorites'), findsOneWidget);

        Get.toNamed(AppRoutes.profile);
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Profile'), findsOneWidget);

        Get.toNamed(AppRoutes.settings);
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Settings'), findsOneWidget);
      });
    });
  });
}
