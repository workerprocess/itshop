import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_app/domain/entities/product.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.category,
    required super.images,
    required super.brand,
    required super.specifications,
    required super.isRecommended,
    required super.isBestSeller,
    required super.rating,
    required super.reviewCount,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  factory ProductModel.fromEntity(Product product) => ProductModel(
        id: product.id,
        name: product.name,
        description: product.description,
        price: product.price,
        category: product.category,
        images: product.images,
        brand: product.brand,
        specifications: product.specifications,
        isRecommended: product.isRecommended,
        isBestSeller: product.isBestSeller,
        rating: product.rating,
        reviewCount: product.reviewCount,
        createdAt: product.createdAt,
        updatedAt: product.updatedAt,
      );

  Product toEntity() => Product(
        id: id,
        name: name,
        description: description,
        price: price,
        category: category,
        images: images,
        brand: brand,
        specifications: specifications,
        isRecommended: isRecommended,
        isBestSeller: isBestSeller,
        rating: rating,
        reviewCount: reviewCount,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
