import 'package:get/get.dart';
import 'package:mobile_app/domain/entities/product.dart';
import 'package:mobile_app/domain/usecases/product_usecases.dart';
import 'package:mobile_app/domain/usecases/user_activity_usecases.dart';

class ProductDetailController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxList<Product> _relatedProducts = <Product>[].obs;
  final RxBool _isFavorite = false.obs;
  
  late Product product;
  
  bool get isLoading => _isLoading.value;
  List<Product> get relatedProducts => _relatedProducts;
  bool get isFavorite => _isFavorite.value;

  @override
  void onInit() {
    super.onInit();
    product = Get.arguments as Product;
    _recordView();
    loadRelatedProducts();
  }

  Future<void> loadRelatedProducts() async {
    try {
      _isLoading.value = true;
      
      final getProductsByCategoryUseCase = Get.find<GetProductsByCategoryUseCase>();
      final categoryProducts = await getProductsByCategoryUseCase.call(product.category);
      
      // Filter out current product and limit to 5
      _relatedProducts.value = categoryProducts
          .where((p) => p.id != product.id)
          .take(5)
          .toList();
      
    } catch (e) {
      print('Error loading related products: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> _recordView() async {
    try {
      final recordUseCase = Get.find<RecordProductViewedUseCase>();
      await recordUseCase.call(product.id);
    } catch (e) {
      // ignore errors for analytics
    }
  }

  void toggleFavorite() {
    _isFavorite.value = !_isFavorite.value;
    
    Get.snackbar(
      _isFavorite.value ? 'เพิ่มรายการโปรด' : 'ลบออกจากรายการโปรด',
      '${product.name} ${_isFavorite.value ? 'ถูกเพิ่มลงรายการโปรดแล้ว' : 'ถูกลบออกจากรายการโปรดแล้ว'}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void addToCart() {
    Get.snackbar(
      'เพิ่มลงตะกร้า',
      '${product.name} ถูกเพิ่มลงตะกร้าแล้ว',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void buyNow() {
    Get.snackbar(
      'ซื้อทันที',
      'กำลังดำเนินการซื้อ ${product.name}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void shareProduct() {
    Get.snackbar(
      'แชร์สินค้า',
      'กำลังแชร์ ${product.name}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void navigateToProduct(Product relatedProduct) {
    Get.toNamed('/product-detail', arguments: relatedProduct);
  }
}
