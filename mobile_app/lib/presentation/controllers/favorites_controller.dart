import 'package:get/get.dart';
import 'package:mobile_app/domain/entities/product.dart';
import 'package:mobile_app/domain/usecases/product_usecases.dart';

class FavoritesController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxList<Product> _favoriteProducts = <Product>[].obs;
  final RxBool _isGridView = true.obs;
  
  bool get isLoading => _isLoading.value;
  List<Product> get favoriteProducts => _favoriteProducts;
  bool get isGridView => _isGridView.value;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    try {
      _isLoading.value = true;
      
      // TODO: Implement actual favorites loading from local storage or API
      // For now, we'll simulate with recommended products
      final getRecommendedProductsUseCase = Get.find<GetRecommendedProductsUseCase>();
      final recommended = await getRecommendedProductsUseCase.call();
      
      // Simulate favorites by taking first 3 recommended products
      _favoriteProducts.value = recommended.take(3).toList();
      
    } catch (e) {
      print('Error loading favorites: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  void toggleFavorite(Product product) {
    if (_favoriteProducts.any((p) => p.id == product.id)) {
      removeFromFavorites(product);
    } else {
      addToFavorites(product);
    }
  }

  void addToFavorites(Product product) {
    if (!_favoriteProducts.any((p) => p.id == product.id)) {
      _favoriteProducts.add(product);
      Get.snackbar(
        'เพิ่มรายการโปรด',
        '${product.name} ถูกเพิ่มลงรายการโปรดแล้ว',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void removeFromFavorites(Product product) {
    _favoriteProducts.removeWhere((p) => p.id == product.id);
    Get.snackbar(
      'ลบออกจากรายการโปรด',
      '${product.name} ถูกลบออกจากรายการโปรดแล้ว',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void clearAllFavorites() {
    _favoriteProducts.clear();
    Get.snackbar(
      'ล้างรายการโปรด',
      'รายการโปรดทั้งหมดถูกลบแล้ว',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void toggleViewMode() {
    _isGridView.value = !_isGridView.value;
  }

  bool isFavorite(Product product) {
    return _favoriteProducts.any((p) => p.id == product.id);
  }
}