import 'package:mobile_app/domain/entities/product.dart';
import 'package:mobile_app/domain/repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository _repository;

  GetProductsUseCase(this._repository);

  Future<List<Product>> call() async {
    return await _repository.getAllProducts();
  }
}

class GetProductByIdUseCase {
  final ProductRepository _repository;

  GetProductByIdUseCase(this._repository);

  Future<Product> call(String id) async {
    return await _repository.getProductById(id);
  }
}

class GetProductsByCategoryUseCase {
  final ProductRepository _repository;

  GetProductsByCategoryUseCase(this._repository);

  Future<List<Product>> call(String categoryId) async {
    return await _repository.getProductsByCategory(categoryId);
  }
}

class GetRecommendedProductsUseCase {
  final ProductRepository _repository;

  GetRecommendedProductsUseCase(this._repository);

  Future<List<Product>> call() async {
    return await _repository.getRecommendedProducts();
  }
}

class GetBestSellerProductsUseCase {
  final ProductRepository _repository;

  GetBestSellerProductsUseCase(this._repository);

  Future<List<Product>> call() async {
    return await _repository.getBestSellerProducts();
  }
}

class SearchProductsUseCase {
  final ProductRepository _repository;

  SearchProductsUseCase(this._repository);

  Future<List<Product>> call(String query) async {
    return await _repository.searchProducts(query);
  }
}
