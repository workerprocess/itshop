import 'package:get/get.dart';
import 'package:mobile_app/presentation/controllers/products_controller.dart';

class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize products controller only
    // App dependencies are already initialized in RootBinding
    Get.put<ProductsController>(ProductsController());
  }
}
