import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/domain/entities/category.dart';
import 'package:mobile_app/domain/entities/product.dart';
import 'package:mobile_app/domain/usecases/product_usecases.dart';
import 'package:mobile_app/domain/usecases/category_usecases.dart';

class ProductSearchController extends GetxController {
  final TextEditingController textSearchController = TextEditingController();
  final RxBool _isLoading = false.obs;
  final RxList<Product> _searchResults = <Product>[].obs;
  final RxList<Category> _categories = <Category>[].obs;
  final RxString _selectedCategory = ''.obs;
  final RxBool _isGridView = true.obs;
  
  bool get isLoading => _isLoading.value;
  List<Product> get searchResults => _searchResults;
  List<Category> get categories => _categories;
  String get selectedCategory => _selectedCategory.value;
  bool get isGridView => _isGridView.value;

  @override
  void onInit() {
    super.onInit();
    print('🔍 ProductSearchController: onInit() called');
    loadCategories();
  }

  @override
  void onClose() {
    textSearchController.dispose();
    super.onClose();
  }

  Future<void> loadCategories() async {
    try {
      print('🔍 ProductSearchController: Starting to load categories...');
      _isLoading.value = true;
      
      final getCategoriesUseCase = Get.find<GetCategoriesUseCase>();
      print('🔍 ProductSearchController: Found GetCategoriesUseCase: $getCategoriesUseCase');
      
      final allCategories = await getCategoriesUseCase.call();
      print('🔍 ProductSearchController: Got ${allCategories.length} categories');
      
      _categories.value = allCategories;
      print('🔍 ProductSearchController: Categories loaded successfully: ${_categories.length}');
      
    } catch (e) {
      print('❌ Error loading categories: $e');
      print('❌ Error type: ${e.runtimeType}');
    } finally {
      _isLoading.value = false;
      print('🔍 ProductSearchController: Loading completed, isLoading = ${_isLoading.value}');
    }
  }

  Future<void> searchProducts(String query) async {
    print('🔍 ProductSearchController: searchProducts called with query: "$query"');
    
    if (query.isEmpty) {
      print('🔍 ProductSearchController: Query is empty, clearing results');
      _searchResults.clear();
      return;
    }

    try {
      print('🔍 ProductSearchController: Starting search for: "$query"');
      _isLoading.value = true;
      
      final searchProductsUseCase = Get.find<SearchProductsUseCase>();
      print('🔍 ProductSearchController: Found SearchProductsUseCase: $searchProductsUseCase');
      
      final results = await searchProductsUseCase.call(query);
      print('🔍 ProductSearchController: Got ${results.length} search results');
      
      _searchResults.value = results;
      print('🔍 ProductSearchController: Search results updated: ${_searchResults.length}');
      
    } catch (e) {
      print('❌ Error searching products: $e');
      print('❌ Error type: ${e.runtimeType}');
    } finally {
      _isLoading.value = false;
      print('🔍 ProductSearchController: Search completed, isLoading = ${_isLoading.value}');
    }
  }

  Future<void> filterByCategory(String categoryId) async {
    try {
      _isLoading.value = true;
      _selectedCategory.value = categoryId;
      
      final getProductsByCategoryUseCase = Get.find<GetProductsByCategoryUseCase>();
      final categoryProducts = await getProductsByCategoryUseCase.call(categoryId);
      _searchResults.value = categoryProducts;
      
    } catch (e) {
      print('Error filtering by category: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> clearCategoryFilter() async {
    _selectedCategory.value = '';
    if (textSearchController.text.isNotEmpty) {
      await searchProducts(textSearchController.text);
    } else {
      _searchResults.clear();
    }
  }

  void clearSearch() {
    textSearchController.clear();
    _searchResults.clear();
  }

  void clearAllFilters() {
    textSearchController.clear();
    _selectedCategory.value = '';
    _searchResults.clear();
  }

  void toggleViewMode() {
    _isGridView.value = !_isGridView.value;
  }

  Future<void> refreshSearch() async {
    if (textSearchController.text.isNotEmpty) {
      await searchProducts(textSearchController.text);
    } else if (_selectedCategory.isNotEmpty) {
      await filterByCategory(_selectedCategory.value);
    }
  }

  String getCategoryName(String categoryId) {
    try {
      final category = _categories.firstWhere((cat) => cat.id == categoryId);
      return category.name;
    } catch (e) {
      return categoryId;
    }
  }
}