import 'package:mobile_app/core/network/api_client.dart';
import 'package:mobile_app/data/datasources/product_data_source.dart';
import 'package:mobile_app/data/models/product_model.dart';
import 'package:mobile_app/domain/entities/product.dart';
import 'package:mobile_app/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource _dataSource;
  final bool _useMockData;

  ProductRepositoryImpl(this._dataSource, {bool useMockData = true}) 
      : _useMockData = useMockData;

  @override
  Future<List<Product>> getAllProducts() async {
    try {
      final List<ProductModel> models = _useMockData 
          ? await _dataSource.getProductsFromMock()
          : await _dataSource.getProductsFromApi();
      
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get all products: $e');
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    try {
      final ProductModel model = _useMockData 
          ? (await _dataSource.getProductsFromMock()).firstWhere((p) => p.id == id)
          : await _dataSource.getProductByIdFromApi(id);
      
      return model.toEntity();
    } catch (e) {
      throw Exception('Failed to get product by id: $e');
    }
  }

  @override
  Future<List<Product>> getProductsByCategory(String categoryId) async {
    try {
      final List<Product> allProducts = await getAllProducts();
      return allProducts.where((product) => product.category == categoryId).toList();
    } catch (e) {
      throw Exception('Failed to get products by category: $e');
    }
  }

  @override
  Future<List<Product>> getRecommendedProducts() async {
    try {
      final List<Product> allProducts = await getAllProducts();
      return allProducts.where((product) => product.isRecommended).toList();
    } catch (e) {
      throw Exception('Failed to get recommended products: $e');
    }
  }

  @override
  Future<List<Product>> getBestSellerProducts() async {
    try {
      final List<Product> allProducts = await getAllProducts();
      return allProducts.where((product) => product.isBestSeller).toList();
    } catch (e) {
      throw Exception('Failed to get best seller products: $e');
    }
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    try {
      final List<Product> allProducts = await getAllProducts();
      return allProducts.where((product) => 
          product.name.toLowerCase().contains(query.toLowerCase()) ||
          product.description.toLowerCase().contains(query.toLowerCase()) ||
          product.brand.toLowerCase().contains(query.toLowerCase())
      ).toList();
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }
}
