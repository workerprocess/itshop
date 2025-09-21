import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mobile_app/domain/entities/product.dart';
import 'package:mobile_app/presentation/controllers/favorites_controller.dart';
import 'package:mobile_app/presentation/pages/favorites_page.dart';

void main() {
  group('FavoritesPage Tests', () {
    late FavoritesController mockController;

    setUp(() {
      Get.reset();
      mockController = FavoritesController();
      Get.put<FavoritesController>(mockController);
    });

    tearDown(() {
      Get.reset();
    });

    testWidgets('should display empty state when no favorites', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: FavoritesPage(),
        ),
      );

      // Assert
      expect(find.text('ยังไม่มีสินค้าที่บันทึกไว้'), findsOneWidget);
      expect(find.text('เพิ่มสินค้าที่คุณชอบลงรายการโปรด'), findsOneWidget);
      expect(find.text('ดูสินค้า'), findsOneWidget);
    });

    testWidgets('should display app bar with actions', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: FavoritesPage(),
        ),
      );

      // Assert
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Favorites'), findsAtLeastNWidgets(1));
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('should display bottom navigation bar', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: FavoritesPage(),
        ),
      );

      // Assert
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Products'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Favorites'), findsAtLeastNWidgets(1));
      expect(find.text('Profile'), findsOneWidget);
    });
  });

  group('FavoritesController Tests', () {
    setUp(() {
      Get.reset();
    });

    tearDown(() {
      Get.reset();
    });

    test('should initialize controller without errors', () {
      final controller = FavoritesController();
      expect(controller, isA<FavoritesController>());
      expect(controller.isLoading, false);
      expect(controller.favoriteProducts, isEmpty);
      expect(controller.isGridView, true);
    });

    test('should toggle view mode', () {
      final controller = FavoritesController();
      expect(controller.isGridView, true);
      
      controller.toggleViewMode();
      expect(controller.isGridView, false);
      
      controller.toggleViewMode();
      expect(controller.isGridView, true);
    });

    test('should check if product is favorite', () {
      final controller = FavoritesController();
      final product = Product(
        id: 'prod_001',
        name: 'Test Product',
        description: 'Test Description',
        price: 1000.00,
        category: 'test',
        images: [],
        brand: 'Test Brand',
        specifications: {},
        isRecommended: false,
        isBestSeller: false,
        rating: 3.0,
        reviewCount: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      expect(controller.isFavorite(product), false);
      
      controller.addToFavorites(product);
      expect(controller.isFavorite(product), true);
      
      controller.removeFromFavorites(product);
      expect(controller.isFavorite(product), false);
    });
  });
}
