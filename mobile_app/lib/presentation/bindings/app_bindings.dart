import 'package:get/get.dart';
import 'package:mobile_app/core/network/api_client.dart';
import 'package:mobile_app/data/datasources/product_data_source.dart';
import 'package:mobile_app/data/repositories/product_repository_impl.dart';
import 'package:mobile_app/data/repositories/category_repository_impl.dart';
import 'package:mobile_app/domain/repositories/product_repository.dart';
import 'package:mobile_app/domain/repositories/category_repository.dart';
import 'package:mobile_app/domain/usecases/product_usecases.dart';
import 'package:mobile_app/domain/usecases/category_usecases.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Core dependencies
    Get.put<ApiClient>(ApiClient());
    
    // Data sources
    Get.put<ProductDataSource>(ProductDataSource(Get.find()));
    
    // Repositories
    Get.put<ProductRepository>(ProductRepositoryImpl(Get.find(), useMockData: true));
    Get.put<CategoryRepository>(CategoryRepositoryImpl(Get.find(), useMockData: true));
    
    // Use cases
    Get.put(GetProductsUseCase(Get.find()));
    Get.put(GetProductByIdUseCase(Get.find()));
    Get.put(GetProductsByCategoryUseCase(Get.find()));
    Get.put(GetRecommendedProductsUseCase(Get.find()));
    Get.put(GetBestSellerProductsUseCase(Get.find()));
    Get.put(SearchProductsUseCase(Get.find()));
    Get.put(GetCategoriesUseCase(Get.find()));
    Get.put(GetCategoryByIdUseCase(Get.find()));
  }
}
