import 'package:get/get.dart';
import 'package:mobile_app/domain/entities/product.dart';
import 'package:mobile_app/domain/usecases/product_usecases.dart';

class HomeController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxList<Product> _recommendedProducts = <Product>[].obs;
  final RxList<Product> _bestSellerProducts = <Product>[].obs;
  
  bool get isLoading => _isLoading.value;
  List<Product> get recommendedProducts => _recommendedProducts;
  List<Product> get bestSellerProducts => _bestSellerProducts;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    try {
      _isLoading.value = true;
      
      // Load recommended products
      final recommendedUseCase = Get.find<GetRecommendedProductsUseCase>();
      final recommended = await recommendedUseCase.call();
      _recommendedProducts.value = recommended;
      
      // Load best seller products
      final bestSellerUseCase = Get.find<GetBestSellerProductsUseCase>();
      final bestSellers = await bestSellerUseCase.call();
      _bestSellerProducts.value = bestSellers;
      
    } catch (e) {
      // Handle error
      print('Error loading data: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    await loadData();
  }
}
