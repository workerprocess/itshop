import 'package:mobile_app/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getAllProducts();
  Future<Product> getProductById(String id);
  Future<List<Product>> getProductsByCategory(String categoryId);
  Future<List<Product>> getRecommendedProducts();
  Future<List<Product>> getBestSellerProducts();
  Future<List<Product>> searchProducts(String query);
}
