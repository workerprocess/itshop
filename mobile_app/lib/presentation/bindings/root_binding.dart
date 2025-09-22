import 'package:get/get.dart';
import 'package:mobile_app/presentation/bindings/app_bindings.dart';
import 'package:mobile_app/presentation/controllers/root_controller.dart';
import 'package:mobile_app/presentation/controllers/home_controller.dart';
import 'package:mobile_app/presentation/controllers/products_controller.dart';
import 'package:mobile_app/presentation/controllers/product_search_controller.dart';
import 'package:mobile_app/presentation/controllers/favorites_controller.dart';
import 'package:mobile_app/presentation/controllers/profile_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize app dependencies
    AppBindings().dependencies();
    
    // Initialize root controller first
    Get.put<RootController>(RootController());
    
    // Initialize all page controllers for the root page immediately
    Get.put<HomeController>(HomeController());
    Get.put<ProductsController>(ProductsController());
    Get.put<ProductSearchController>(ProductSearchController(), permanent: true);
    Get.put<FavoritesController>(FavoritesController());
    Get.put<ProfileController>(ProfileController());
  }
}
