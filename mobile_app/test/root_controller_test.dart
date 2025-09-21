import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mobile_app/presentation/controllers/root_controller.dart';

void main() {
  group('RootController Tests', () {
    late RootController controller;

    setUp(() {
      Get.reset();
      controller = Get.put(RootController());
    });

    tearDown(() {
      Get.reset();
    });

    test('should initialize with currentIndex 0', () {
      // Assert
      expect(controller.currentIndex, 0);
    });

    test('should change tab index correctly', () {
      // Act
      controller.changeTab(2);

      // Assert
      expect(controller.currentIndex, 2);
    });

    test('should change tab index multiple times', () {
      // Act
      controller.changeTab(1);
      expect(controller.currentIndex, 1);

      controller.changeTab(3);
      expect(controller.currentIndex, 3);

      controller.changeTab(0);
      expect(controller.currentIndex, 0);
    });

    test('should handle invalid tab index gracefully', () {
      // Act
      controller.changeTab(-1);
      expect(controller.currentIndex, -1);

      controller.changeTab(10);
      expect(controller.currentIndex, 10);
    });
  });
}
