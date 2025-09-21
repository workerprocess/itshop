import 'package:get/get.dart';
import 'package:mobile_app/presentation/controllers/profile_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize profile controller if not already initialized
    // App dependencies are already initialized in RootBinding
    if (!Get.isRegistered<ProfileController>()) {
      Get.put<ProfileController>(ProfileController());
    }
  }
}
