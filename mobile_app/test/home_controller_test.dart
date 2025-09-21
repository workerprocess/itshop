import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mobile_app/presentation/bindings/app_bindings.dart';
import 'package:mobile_app/presentation/controllers/home_controller.dart';

void main() {
  group('HomeController Tests', () {
    setUp(() {
      Get.reset();
      AppBindings().dependencies();
    });

    tearDown(() {
      Get.reset();
    });

    test('should initialize and load recommended products', () async {
      // Arrange
      final controller = Get.put<HomeController>(HomeController());
      
      // Wait for data to load
      await Future.delayed(const Duration(seconds: 2));
      
      // Assert
      expect(controller.isLoading, false);
      expect(controller.recommendedProducts.isNotEmpty, true);
      print('Recommended products count: ${controller.recommendedProducts.length}');
      
      // Check if products have isRecommended = true
      for (final product in controller.recommendedProducts) {
        expect(product.isRecommended, true);
        print('Recommended product: ${product.name}');
      }
    });

    test('should load best seller products', () async {
      // Arrange
      final controller = Get.put<HomeController>(HomeController());
      
      // Wait for data to load
      await Future.delayed(const Duration(seconds: 2));
      
      // Assert
      expect(controller.isLoading, false);
      expect(controller.bestSellerProducts.isNotEmpty, true);
      print('Best seller products count: ${controller.bestSellerProducts.length}');
      
      // Check if products have isBestSeller = true
      for (final product in controller.bestSellerProducts) {
        expect(product.isBestSeller, true);
        print('Best seller product: ${product.name}');
      }
    });

    test('should refresh data successfully', () async {
      // Arrange
      final controller = Get.put<HomeController>(HomeController());
      
      // Wait for initial load
      await Future.delayed(const Duration(seconds: 2));
      
      // Act
      await controller.refreshData();
      
      // Assert
      expect(controller.isLoading, false);
      expect(controller.recommendedProducts.isNotEmpty, true);
      expect(controller.bestSellerProducts.isNotEmpty, true);
    });
  });
}
