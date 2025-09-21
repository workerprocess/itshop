import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/domain/entities/product.dart';
import 'package:mobile_app/presentation/widgets/product_card.dart';

void main() {
  group('ProductCard Tests', () {
    late Product mockProduct;

    setUp(() {
      mockProduct = Product(
        id: 'prod_001',
        name: 'MacBook Pro 16-inch',
        description: 'Powerful laptop for professionals',
        price: 89990.00,
        category: 'computers',
        images: ['https://example.com/macbook1.jpg'],
        brand: 'Apple',
        specifications: {
          'processor': 'M2 Pro',
          'memory': '16GB',
          'storage': '512GB SSD'
        },
        isRecommended: true,
        isBestSeller: true,
        rating: 4.8,
        reviewCount: 1250,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    });

    testWidgets('should display product information correctly', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCard(product: mockProduct),
          ),
        ),
      );

      // Assert
      expect(find.text('MacBook Pro 16-inch'), findsOneWidget);
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('฿89990'), findsOneWidget);
      expect(find.text('4.8'), findsOneWidget);
      expect(find.text('แนะนำ'), findsOneWidget);
      expect(find.text('ขายดี'), findsOneWidget);
    });

    testWidgets('should call onTap when tapped', (WidgetTester tester) async {
      // Arrange
      bool tapped = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCard(
              product: mockProduct,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      // Assert
      expect(tapped, true);
    });

    testWidgets('should display badges for recommended and best seller products', (WidgetTester tester) async {
      // Arrange
      final recommendedProduct = Product(
        id: 'prod_002',
        name: 'iPhone 15',
        description: 'Latest iPhone',
        price: 42900.00,
        category: 'phones',
        images: ['https://example.com/iphone.jpg'],
        brand: 'Apple',
        specifications: {'processor': 'A17 Pro'},
        isRecommended: true,
        isBestSeller: false,
        rating: 4.9,
        reviewCount: 2100,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCard(product: recommendedProduct),
          ),
        ),
      );

      // Assert
      expect(find.text('แนะนำ'), findsOneWidget);
      expect(find.text('ขายดี'), findsNothing);
    });

    testWidgets('should handle products without images', (WidgetTester tester) async {
      // Arrange
      final productWithoutImages = Product(
        id: 'prod_003',
        name: 'Test Product',
        description: 'Product without images',
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
          home: Scaffold(
            body: ProductCard(product: productWithoutImages),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.image_not_supported), findsOneWidget);
      expect(find.text('Test Product'), findsOneWidget);
    });
  });
}
