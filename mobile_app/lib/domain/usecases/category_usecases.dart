import 'package:mobile_app/domain/entities/category.dart';
import 'package:mobile_app/domain/repositories/category_repository.dart';

class GetCategoriesUseCase {
  final CategoryRepository _repository;

  GetCategoriesUseCase(this._repository);

  Future<List<Category>> call() async {
    return await _repository.getCategories();
  }
}

class GetCategoryByIdUseCase {
  final CategoryRepository _repository;

  GetCategoryByIdUseCase(this._repository);

  Future<Category?> call(String id) async {
    return await _repository.getCategoryById(id);
  }
}
