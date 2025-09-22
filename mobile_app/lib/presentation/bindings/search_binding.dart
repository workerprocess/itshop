import 'package:get/get.dart';
import 'package:mobile_app/presentation/controllers/product_search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize search controller only
    // App dependencies are already initialized in RootBinding
    if (!Get.isRegistered<ProductSearchController>()) {
      Get.put<ProductSearchController>(ProductSearchController());
    }
  }
}
