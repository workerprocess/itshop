import 'package:get/get.dart';
import 'package:mobile_app/presentation/controllers/product_detail_controller.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize product detail controller only
    // App dependencies are already initialized in RootBinding
    Get.put<ProductDetailController>(ProductDetailController());
  }
}
