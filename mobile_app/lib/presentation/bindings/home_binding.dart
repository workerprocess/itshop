import 'package:get/get.dart';
import 'package:mobile_app/presentation/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize home controller only
    // App dependencies are already initialized in RootBinding
    if (!Get.isRegistered<HomeController>()) {
      Get.put<HomeController>(HomeController());
    }
  }
}
