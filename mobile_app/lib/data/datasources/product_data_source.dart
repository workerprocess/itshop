import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:mobile_app/core/network/api_client.dart';
import 'package:mobile_app/data/models/product_model.dart';
import 'package:mobile_app/data/models/category_model.dart';
import 'package:mobile_app/domain/entities/product.dart';
import 'package:mobile_app/domain/entities/category.dart';
import 'package:mobile_app/domain/repositories/product_repository.dart';

class ProductDataSource {
  final ApiClient _apiClient;

  ProductDataSource(this._apiClient);

  Future<List<ProductModel>> getProductsFromApi() async {
    try {
      final response = await _apiClient.get('/products');
      final List<dynamic> jsonList = response.data;
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch products from API: $e');
    }
  }

  Future<ProductModel> getProductByIdFromApi(String id) async {
    try {
      final response = await _apiClient.get('/products/$id');
      return ProductModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch product by id from API: $e');
    }
  }

  Future<List<ProductModel>> getProductsFromMock() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/json/products.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load mock products: $e');
    }
  }

  Future<List<CategoryModel>> getCategoriesFromApi() async {
    try {
      final response = await _apiClient.get('/categories');
      final List<dynamic> jsonList = response.data;
      return jsonList.map((json) => CategoryModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch categories from API: $e');
    }
  }

  Future<List<CategoryModel>> getCategoriesFromMock() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/json/categories.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => CategoryModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load mock categories: $e');
    }
  }
}
