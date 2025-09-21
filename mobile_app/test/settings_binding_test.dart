import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mobile_app/presentation/bindings/settings_binding.dart';
import 'package:mobile_app/presentation/controllers/profile_controller.dart';

void main() {
  group('SettingsBinding Tests', () {
    setUp(() {
      Get.reset();
    });

    tearDown(() {
      Get.reset();
    });

    test('should initialize dependencies correctly', () {
      // Arrange & Act
      SettingsBinding().dependencies();
      
      // Assert
      expect(Get.isRegistered<ProfileController>(), true);
      
      final controller = Get.find<ProfileController>();
      expect(controller, isA<ProfileController>());
    });

    test('should not create duplicate ProfileController', () {
      // Arrange
      SettingsBinding().dependencies();
      final firstController = Get.find<ProfileController>();
      
      // Act - Call dependencies again
      SettingsBinding().dependencies();
      final secondController = Get.find<ProfileController>();
      
      // Assert - Should be the same instance
      expect(firstController, equals(secondController));
    });
  });
}
