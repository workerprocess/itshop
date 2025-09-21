import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_app/domain/entities/category.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.description,
    required super.icon,
    required super.parentId,
    required super.subcategories,
    required super.productCount,
    required super.isActive,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  factory CategoryModel.fromEntity(Category category) => CategoryModel(
        id: category.id,
        name: category.name,
        description: category.description,
        icon: category.icon,
        parentId: category.parentId,
        subcategories: category.subcategories,
        productCount: category.productCount,
        isActive: category.isActive,
      );

  Category toEntity() => Category(
        id: id,
        name: name,
        description: description,
        icon: icon,
        parentId: parentId,
        subcategories: subcategories,
        productCount: productCount,
        isActive: isActive,
      );
}
