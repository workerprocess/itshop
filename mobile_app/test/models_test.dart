import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/data/models/product_model.dart';
import 'package:mobile_app/data/models/category_model.dart';
import 'package:mobile_app/domain/entities/product.dart';
import 'package:mobile_app/domain/entities/category.dart';

void main() {
  group('ProductModel Tests', () {
    test('should create ProductModel from JSON', () {
      // Arrange
      final json = {
        'id': 'prod_001',
        'name': 'MacBook Pro 16-inch',
        'description': 'Powerful laptop for professionals',
        'price': 89990.00,
        'category': 'computers',
        'images': ['https://example.com/macbook1.jpg'],
        'brand': 'Apple',
        'specifications': {
          'processor': 'M2 Pro',
          'memory': '16GB',
          'storage': '512GB SSD'
        },
        'isRecommended': true,
        'isBestSeller': true,
        'rating': 4.8,
        'reviewCount': 1250,
        'createdAt': '2024-01-01T00:00:00Z',
        'updatedAt': '2024-12-19T00:00:00Z'
      };

      // Act
      final productModel = ProductModel.fromJson(json);

      // Assert
      expect(productModel.id, 'prod_001');
      expect(productModel.name, 'MacBook Pro 16-inch');
      expect(productModel.price, 89990.00);
      expect(productModel.brand, 'Apple');
      expect(productModel.isRecommended, true);
      expect(productModel.isBestSeller, true);
      expect(productModel.rating, 4.8);
      expect(productModel.reviewCount, 1250);
    });

    test('should convert ProductModel to JSON', () {
      // Arrange
      final productModel = ProductModel(
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
        createdAt: DateTime.parse('2024-01-01T00:00:00Z'),
        updatedAt: DateTime.parse('2024-12-19T00:00:00Z'),
      );

      // Act
      final json = productModel.toJson();

      // Assert
      expect(json['id'], 'prod_001');
      expect(json['name'], 'MacBook Pro 16-inch');
      expect(json['price'], 89990.00);
      expect(json['brand'], 'Apple');
      expect(json['isRecommended'], true);
      expect(json['isBestSeller'], true);
      expect(json['rating'], 4.8);
      expect(json['reviewCount'], 1250);
    });

    test('should convert ProductModel to Entity', () {
      // Arrange
      final productModel = ProductModel(
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
        createdAt: DateTime.parse('2024-01-01T00:00:00Z'),
        updatedAt: DateTime.parse('2024-12-19T00:00:00Z'),
      );

      // Act
      final product = productModel.toEntity();

      // Assert
      expect(product, isA<Product>());
      expect(product.id, 'prod_001');
      expect(product.name, 'MacBook Pro 16-inch');
      expect(product.price, 89990.00);
      expect(product.brand, 'Apple');
    });
  });

  group('CategoryModel Tests', () {
    test('should create CategoryModel from JSON', () {
      // Arrange
      final json = {
        'id': 'cat_001',
        'name': 'Computers',
        'description': 'Laptops, desktops, and workstations',
        'icon': 'assets/icons/computer.svg',
        'parentId': '',
        'subcategories': ['laptops', 'desktops', 'workstations'],
        'productCount': 45,
        'isActive': true
      };

      // Act
      final categoryModel = CategoryModel.fromJson(json);

      // Assert
      expect(categoryModel.id, 'cat_001');
      expect(categoryModel.name, 'Computers');
      expect(categoryModel.description, 'Laptops, desktops, and workstations');
      expect(categoryModel.icon, 'assets/icons/computer.svg');
      expect(categoryModel.parentId, '');
      expect(categoryModel.subcategories, ['laptops', 'desktops', 'workstations']);
      expect(categoryModel.productCount, 45);
      expect(categoryModel.isActive, true);
    });

    test('should convert CategoryModel to Entity', () {
      // Arrange
      final categoryModel = CategoryModel(
        id: 'cat_001',
        name: 'Computers',
        description: 'Laptops, desktops, and workstations',
        icon: 'assets/icons/computer.svg',
        parentId: '',
        subcategories: ['laptops', 'desktops', 'workstations'],
        productCount: 45,
        isActive: true,
      );

      // Act
      final category = categoryModel.toEntity();

      // Assert
      expect(category, isA<Category>());
      expect(category.id, 'cat_001');
      expect(category.name, 'Computers');
      expect(category.productCount, 45);
      expect(category.isActive, true);
    });
  });
}
