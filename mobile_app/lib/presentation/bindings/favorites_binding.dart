import 'package:get/get.dart';
import 'package:mobile_app/presentation/controllers/favorites_controller.dart';

class FavoritesBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize favorites controller only
    // App dependencies are already initialized in RootBinding
    Get.put<FavoritesController>(FavoritesController());
  }
}
