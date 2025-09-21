import 'package:get/get.dart';
import 'package:mobile_app/presentation/controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize profile controller only
    // App dependencies are already initialized in RootBinding
    Get.put<ProfileController>(ProfileController());
  }
}
