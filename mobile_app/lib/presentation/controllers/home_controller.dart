import 'package:get/get.dart';
import 'package:mobile_app/domain/entities/product.dart';
import 'package:mobile_app/domain/usecases/product_usecases.dart';
import 'package:mobile_app/domain/entities/membership_status.dart';
import 'package:mobile_app/domain/usecases/user_activity_usecases.dart';

class HomeController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxList<Product> _recommendedProducts = <Product>[].obs;
  final RxList<Product> _bestSellerProducts = <Product>[].obs;
  final Rx<MembershipStatus?> _membershipStatus = Rx<MembershipStatus?>(null);
  final RxList<Product> _recentViewed = <Product>[].obs;
  
  bool get isLoading => _isLoading.value;
  List<Product> get recommendedProducts => _recommendedProducts;
  List<Product> get bestSellerProducts => _bestSellerProducts;
  MembershipStatus? get membershipStatus => _membershipStatus.value;
  List<Product> get recentViewed => _recentViewed;

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
      
      // Load membership status (mock)
      final membershipUseCase = Get.find<GetMembershipStatusUseCase>();
      _membershipStatus.value = await membershipUseCase.call();
      
      // Load recent viewed (mock)
      final recentUseCase = Get.find<GetRecentViewedProductsUseCase>();
      _recentViewed.value = await recentUseCase.call(limit: 2);
      
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
