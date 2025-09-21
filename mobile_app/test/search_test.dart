import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mobile_app/domain/entities/category.dart';
import 'package:mobile_app/domain/entities/product.dart';
import 'package:mobile_app/presentation/controllers/product_search_controller.dart';
import 'package:mobile_app/presentation/pages/search_page.dart';

void main() {
  group('SearchPage Tests', () {
    late ProductSearchController mockController;

    setUp(() {
      Get.reset();
      mockController = ProductSearchController();
      Get.put<ProductSearchController>(mockController);
    });

    tearDown(() {
      Get.reset();
    });

    testWidgets('should display search bar', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: SearchPage(),
        ),
      );

      // Assert
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('ค้นหาสินค้า...'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('should display empty state when no search', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: SearchPage(),
        ),
      );

      // Assert
      expect(find.text('ค้นหาสินค้าที่คุณต้องการ'), findsOneWidget);
      expect(find.text('พิมพ์ชื่อสินค้าหรือเลือกหมวดหมู่เพื่อเริ่มค้นหา'), findsOneWidget);
    });

    testWidgets('should display app bar with actions', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: SearchPage(),
        ),
      );

      // Assert
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('should display bottom navigation bar', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: SearchPage(),
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
  });

  group('ProductSearchController Tests', () {
    setUp(() {
      Get.reset();
    });

    tearDown(() {
      Get.reset();
    });

    test('should initialize controller without errors', () {
      final controller = ProductSearchController();
      expect(controller, isA<ProductSearchController>());
      expect(controller.isLoading, false);
      expect(controller.searchResults, isEmpty);
      expect(controller.categories, isEmpty);
      expect(controller.selectedCategory, isEmpty);
      expect(controller.isGridView, true);
    });

    test('should dispose controller properly', () {
      final controller = ProductSearchController();
      controller.onClose();
      // Should not throw any errors
    });
  });
}
