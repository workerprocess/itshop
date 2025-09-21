import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mobile_app/domain/entities/product.dart';
import 'package:mobile_app/presentation/pages/product_detail_page.dart';

void main() {
  group('ProductDetailPage Tests', () {
    late Product mockProduct;

    setUp(() {
      Get.reset();
      mockProduct = Product(
        id: 'prod_001',
        name: 'MacBook Pro 16-inch',
        description: 'Powerful laptop for professionals with M2 Pro chip',
        price: 89990.00,
        category: 'computers',
        images: [
          'https://example.com/macbook1.jpg',
          'https://example.com/macbook2.jpg',
        ],
        brand: 'Apple',
        specifications: {
          'processor': 'M2 Pro',
          'memory': '16GB',
          'storage': '512GB SSD',
          'display': '16.2-inch Liquid Retina XDR',
          'battery': 'Up to 22 hours',
        },
        isRecommended: true,
        isBestSeller: true,
        rating: 4.8,
        reviewCount: 1250,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    });

    tearDown(() {
      Get.reset();
    });

    testWidgets('should display product information correctly', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: ProductDetailPage(product: mockProduct),
        ),
      );

      // Assert
      expect(find.text('MacBook Pro 16-inch'), findsAtLeastNWidgets(1));
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('฿89990'), findsOneWidget);
      expect(find.text('4.8 (1250 รีวิว)'), findsOneWidget);
      expect(find.text('Powerful laptop for professionals with M2 Pro chip'), findsOneWidget);
      expect(find.text('สินค้าแนะนำ'), findsOneWidget);
      expect(find.text('ขายดี'), findsOneWidget);
    });

    testWidgets('should display specifications section', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: ProductDetailPage(product: mockProduct),
        ),
      );

      // Assert
      expect(find.text('ข้อมูลจำเพาะ'), findsOneWidget);
      expect(find.text('processor'), findsOneWidget);
      expect(find.text('M2 Pro'), findsOneWidget);
      expect(find.text('memory'), findsOneWidget);
      expect(find.text('16GB'), findsOneWidget);
      expect(find.text('storage'), findsOneWidget);
      expect(find.text('512GB SSD'), findsOneWidget);
    });

    testWidgets('should display reviews section', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: ProductDetailPage(product: mockProduct),
        ),
      );

      // Assert
      expect(find.text('รีวิวสินค้า'), findsOneWidget);
      expect(find.text('4.8 จาก 5.0'), findsOneWidget);
      expect(find.text('1250 รีวิว'), findsOneWidget);
      expect(find.text('ดูรีวิวทั้งหมด'), findsOneWidget);
    });

    testWidgets('should display related products section', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: ProductDetailPage(product: mockProduct),
        ),
      );

      // Assert
      expect(find.text('สินค้าที่เกี่ยวข้อง'), findsOneWidget);
    });

    testWidgets('should display bottom action buttons', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: ProductDetailPage(product: mockProduct),
        ),
      );

      // Assert
      expect(find.text('เพิ่มลงตะกร้า'), findsOneWidget);
      expect(find.text('ซื้อทันที'), findsOneWidget);
    });

    testWidgets('should display app bar with actions', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: ProductDetailPage(product: mockProduct),
        ),
      );

      // Assert
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      expect(find.byIcon(Icons.share), findsOneWidget);
    });

    testWidgets('should handle products with single image', (WidgetTester tester) async {
      // Arrange
      final singleImageProduct = Product(
        id: 'prod_002',
        name: 'iPhone 15',
        description: 'Latest iPhone',
        price: 42900.00,
        category: 'phones',
        images: ['https://example.com/iphone.jpg'],
        brand: 'Apple',
        specifications: {'processor': 'A17 Pro'},
        isRecommended: false,
        isBestSeller: false,
        rating: 4.9,
        reviewCount: 2100,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: ProductDetailPage(product: singleImageProduct),
        ),
      );

      // Assert
      expect(find.text('iPhone 15'), findsAtLeastNWidgets(1));
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('฿42900'), findsOneWidget);
    });

    testWidgets('should handle products without badges', (WidgetTester tester) async {
      // Arrange
      final noBadgeProduct = Product(
        id: 'prod_003',
        name: 'Test Product',
        description: 'Product without badges',
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

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: ProductDetailPage(product: noBadgeProduct),
        ),
      );

      // Assert
      expect(find.text('Test Product'), findsAtLeastNWidgets(1));
      expect(find.text('สินค้าแนะนำ'), findsNothing);
      expect(find.text('ขายดี'), findsNothing);
    });
  });
}
