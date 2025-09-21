import 'package:get/get.dart';
import 'package:mobile_app/domain/entities/product.dart';
import 'package:mobile_app/domain/usecases/product_usecases.dart';

class ProductsController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxList<Product> _products = <Product>[].obs;
  final RxString _selectedCategory = ''.obs;
  final RxBool _isGridView = true.obs;
  
  bool get isLoading => _isLoading.value;
  List<Product> get products => _products;
  String get selectedCategory => _selectedCategory.value;
  bool get isGridView => _isGridView.value;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      _isLoading.value = true;
      
      final getProductsUseCase = Get.find<GetProductsUseCase>();
      final allProducts = await getProductsUseCase.call();
      _products.value = allProducts;
      
    } catch (e) {
      print('Error loading products: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> loadProductsByCategory(String categoryId) async {
    try {
      _isLoading.value = true;
      _selectedCategory.value = categoryId;
      
      final getProductsByCategoryUseCase = Get.find<GetProductsByCategoryUseCase>();
      final categoryProducts = await getProductsByCategoryUseCase.call(categoryId);
      _products.value = categoryProducts;
      
    } catch (e) {
      print('Error loading products by category: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> searchProducts(String query) async {
    try {
      _isLoading.value = true;
      
      final searchProductsUseCase = Get.find<SearchProductsUseCase>();
      final searchResults = await searchProductsUseCase.call(query);
      _products.value = searchResults;
      
    } catch (e) {
      print('Error searching products: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  void toggleViewMode() {
    _isGridView.value = !_isGridView.value;
  }

  void clearFilters() {
    _selectedCategory.value = '';
    loadProducts();
  }

  Future<void> refreshProducts() async {
    if (_selectedCategory.value.isEmpty) {
      await loadProducts();
    } else {
      await loadProductsByCategory(_selectedCategory.value);
    }
  }
}