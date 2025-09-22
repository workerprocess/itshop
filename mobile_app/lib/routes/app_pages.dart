import 'package:get/get.dart';
import 'package:mobile_app/presentation/bindings/root_binding.dart';
import 'package:mobile_app/presentation/bindings/home_binding.dart';
import 'package:mobile_app/presentation/bindings/products_binding.dart';
import 'package:mobile_app/presentation/bindings/search_binding.dart';
import 'package:mobile_app/presentation/bindings/favorites_binding.dart';
import 'package:mobile_app/presentation/bindings/profile_binding.dart';
import 'package:mobile_app/presentation/bindings/signin_binding.dart';
import 'package:mobile_app/presentation/bindings/settings_binding.dart';
import 'package:mobile_app/presentation/bindings/product_detail_binding.dart';
import 'package:mobile_app/presentation/pages/root_page.dart';
import 'package:mobile_app/presentation/pages/home_page.dart';
import 'package:mobile_app/presentation/pages/products_page.dart';
import 'package:mobile_app/presentation/pages/search_page.dart';
import 'package:mobile_app/presentation/pages/favorites_page.dart';
import 'package:mobile_app/presentation/pages/profile_page.dart';
import 'package:mobile_app/presentation/pages/signin_page.dart';
import 'package:mobile_app/presentation/pages/settings_page.dart';
import 'package:mobile_app/presentation/pages/product_detail_page.dart';
import 'package:mobile_app/routes/app_routes.dart';

class AppPages {
  static final routes = [
    // Root Page - Main entry point with bottom navigation
    GetPage(
      name: AppRoutes.root,
      page: () => const RootPage(),
      binding: RootBinding(),
    ),
    
    // Individual page routes - Direct navigation to specific pages
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.products,
      page: () => const ProductsPage(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: AppRoutes.search,
      page: () => const SearchPage(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: AppRoutes.favorites,
      page: () => const FavoritesPage(),
      binding: FavoritesBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.signin,
      page: () => const SigninPage(),
      binding: SigninBinding(),
    ),
    
    // Modal/Overlay pages
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsPage(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: AppRoutes.productDetail,
      page: () => ProductDetailPage(product: Get.arguments),
      binding: ProductDetailBinding(),
    ),
  ];
}
