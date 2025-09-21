import 'package:mobile_app/core/network/api_client.dart';
import 'package:mobile_app/data/datasources/product_data_source.dart';
import 'package:mobile_app/data/models/category_model.dart';
import 'package:mobile_app/domain/entities/category.dart';
import 'package:mobile_app/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final ProductDataSource _dataSource;
  final bool _useMockData;

  CategoryRepositoryImpl(this._dataSource, {bool useMockData = true}) 
      : _useMockData = useMockData;

  @override
  Future<List<Category>> getCategories() async {
    try {
      final List<CategoryModel> models = _useMockData 
          ? await _dataSource.getCategoriesFromMock()
          : await _dataSource.getCategoriesFromApi();
      
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get all categories: $e');
    }
  }

  @override
  Future<Category?> getCategoryById(String id) async {
    try {
      final List<CategoryModel> models = _useMockData 
          ? await _dataSource.getCategoriesFromMock()
          : await _dataSource.getCategoriesFromApi();
      
      final CategoryModel? model = models.where((c) => c.id == id).firstOrNull;
      return model?.toEntity();
    } catch (e) {
      throw Exception('Failed to get category by id: $e');
    }
  }
}
