import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:mobile_app/data/datasources/product_data_source.dart';
import 'package:mobile_app/data/models/product_model.dart';
import 'package:mobile_app/data/models/category_model.dart';
import 'package:mobile_app/data/repositories/product_repository_impl.dart';
import 'package:mobile_app/domain/entities/product.dart';
import 'package:mobile_app/domain/entities/category.dart';

import 'repository_test.mocks.dart';

@GenerateMocks([ProductDataSource])
void main() {
  group('ProductRepositoryImpl Tests', () {
    late ProductRepositoryImpl repository;
    late MockProductDataSource mockDataSource;

    setUp(() {
      mockDataSource = MockProductDataSource();
      repository = ProductRepositoryImpl(mockDataSource, useMockData: false);
    });

    test('should return all products successfully', () async {
      // Arrange
      final mockProducts = [
        ProductModel(
          id: 'prod_001',
          name: 'MacBook Pro',
          description: 'Powerful laptop',
          price: 89990.00,
          category: 'computers',
          images: ['image1.jpg'],
          brand: 'Apple',
          specifications: {'processor': 'M2 Pro'},
          isRecommended: true,
          isBestSeller: true,
          rating: 4.8,
          reviewCount: 1250,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];

      when(mockDataSource.getProductsFromApi()).thenAnswer((_) async => mockProducts);

      // Act
      final result = await repository.getAllProducts();

      // Assert
      expect(result, isA<List<Product>>());
      expect(result.length, 1);
      expect(result.first.id, 'prod_001');
      expect(result.first.name, 'MacBook Pro');
      verify(mockDataSource.getProductsFromApi()).called(1);
    });

    test('should return products by category', () async {
      // Arrange
      final mockProducts = [
        ProductModel(
          id: 'prod_001',
          name: 'MacBook Pro',
          description: 'Powerful laptop',
          price: 89990.00,
          category: 'computers',
          images: ['image1.jpg'],
          brand: 'Apple',
          specifications: {'processor': 'M2 Pro'},
          isRecommended: true,
          isBestSeller: true,
          rating: 4.8,
          reviewCount: 1250,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        ProductModel(
          id: 'prod_002',
          name: 'iPhone 15',
          description: 'Latest iPhone',
          price: 42900.00,
          category: 'phones',
          images: ['image2.jpg'],
          brand: 'Apple',
          specifications: {'processor': 'A17 Pro'},
          isRecommended: true,
          isBestSeller: true,
          rating: 4.9,
          reviewCount: 2100,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];

      when(mockDataSource.getProductsFromApi()).thenAnswer((_) async => mockProducts);

      // Act
      final result = await repository.getProductsByCategory('computers');

      // Assert
      expect(result, isA<List<Product>>());
      expect(result.length, 1);
      expect(result.first.category, 'computers');
      verify(mockDataSource.getProductsFromApi()).called(1);
    });

    test('should return recommended products', () async {
      // Arrange
      final mockProducts = [
        ProductModel(
          id: 'prod_001',
          name: 'MacBook Pro',
          description: 'Powerful laptop',
          price: 89990.00,
          category: 'computers',
          images: ['image1.jpg'],
          brand: 'Apple',
          specifications: {'processor': 'M2 Pro'},
          isRecommended: true,
          isBestSeller: true,
          rating: 4.8,
          reviewCount: 1250,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        ProductModel(
          id: 'prod_002',
          name: 'iPhone 15',
          description: 'Latest iPhone',
          price: 42900.00,
          category: 'phones',
          images: ['image2.jpg'],
          brand: 'Apple',
          specifications: {'processor': 'A17 Pro'},
          isRecommended: false,
          isBestSeller: true,
          rating: 4.9,
          reviewCount: 2100,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];

      when(mockDataSource.getProductsFromApi()).thenAnswer((_) async => mockProducts);

      // Act
      final result = await repository.getRecommendedProducts();

      // Assert
      expect(result, isA<List<Product>>());
      expect(result.length, 1);
      expect(result.first.isRecommended, true);
      verify(mockDataSource.getProductsFromApi()).called(1);
    });

    test('should search products by query', () async {
      // Arrange
      final mockProducts = [
        ProductModel(
          id: 'prod_001',
          name: 'MacBook Pro',
          description: 'Powerful laptop',
          price: 89990.00,
          category: 'computers',
          images: ['image1.jpg'],
          brand: 'Apple',
          specifications: {'processor': 'M2 Pro'},
          isRecommended: true,
          isBestSeller: true,
          rating: 4.8,
          reviewCount: 1250,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        ProductModel(
          id: 'prod_002',
          name: 'iPhone 15',
          description: 'Latest iPhone',
          price: 42900.00,
          category: 'phones',
          images: ['image2.jpg'],
          brand: 'Apple',
          specifications: {'processor': 'A17 Pro'},
          isRecommended: true,
          isBestSeller: true,
          rating: 4.9,
          reviewCount: 2100,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];

      when(mockDataSource.getProductsFromApi()).thenAnswer((_) async => mockProducts);

      // Act
      final result = await repository.searchProducts('MacBook');

      // Assert
      expect(result, isA<List<Product>>());
      expect(result.length, 1);
      expect(result.first.name, 'MacBook Pro');
      verify(mockDataSource.getProductsFromApi()).called(1);
    });
  });

  group('CategoryRepositoryImpl Tests', () {
    late CategoryRepositoryImpl repository;
    late MockProductDataSource mockDataSource;

    setUp(() {
      mockDataSource = MockProductDataSource();
      repository = CategoryRepositoryImpl(mockDataSource, useMockData: false);
    });

    test('should return all categories successfully', () async {
      // Arrange
      final mockCategories = [
        CategoryModel(
          id: 'cat_001',
          name: 'Computers',
          description: 'Laptops, desktops, and workstations',
          icon: 'assets/icons/computer.svg',
          parentId: '',
          subcategories: ['laptops', 'desktops'],
          productCount: 45,
          isActive: true,
        ),
      ];

      when(mockDataSource.getCategoriesFromApi()).thenAnswer((_) async => mockCategories);

      // Act
      final result = await repository.getAllCategories();

      // Assert
      expect(result, isA<List<Category>>());
      expect(result.length, 1);
      expect(result.first.id, 'cat_001');
      expect(result.first.name, 'Computers');
      verify(mockDataSource.getCategoriesFromApi()).called(1);
    });
  });
}
