import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/domain/entities/category.dart';
import 'package:mobile_app/domain/entities/product.dart';
import 'package:mobile_app/presentation/controllers/product_search_controller.dart';
import 'package:mobile_app/presentation/widgets/product_grid_view.dart';
import 'package:mobile_app/presentation/widgets/product_list_view.dart';
import 'package:mobile_app/presentation/widgets/glass/glass_app_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('🔍 SearchPage: build() called');
    final controller = Get.find<ProductSearchController>();
    
    return Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: GlassAppBar(
          title: 'Search',
          actions: [
            // View Mode Toggle
            Obx(() => IconButton(
              icon: Icon(
                controller.isGridView ? Icons.list : Icons.grid_view,
              ),
              onPressed: () => controller.toggleViewMode(),
            )),
            // Settings
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => Get.toNamed('/settings'),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight),
          child: Column(
            children: [
              // Search Bar
              Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: controller.textSearchController,
                decoration: InputDecoration(
                  hintText: 'ค้นหาสินค้า...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: controller.textSearchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => controller.clearSearch(),
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                onChanged: (value) => controller.searchProducts(value),
              ),
            ),
            
                // Category Filter
                Obx(() {
                  print('🔍 SearchPage: Category Filter Obx - categories.length = ${controller.categories.length}');
                  if (controller.categories.isNotEmpty) {
                    return Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.categories.length,
                        itemBuilder: (context, index) {
                          final category = controller.categories[index];
                          final isSelected = controller.selectedCategory == category.id;
                          
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilterChip(
                              label: Text(category.name),
                              selected: isSelected,
                              onSelected: (selected) {
                                if (selected) {
                                  controller.filterByCategory(category.id);
                                } else {
                                  controller.clearCategoryFilter();
                                }
                              },
                              backgroundColor: Colors.grey[200],
                              selectedColor: Colors.blue[100],
                              checkmarkColor: Colors.blue,
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),
            
            // Active Filters
            Obx(() {
              print('🔍 SearchPage: Active Filters Obx - selectedCategory = "${controller.selectedCategory}", searchText = "${controller.textSearchController.text}"');
              if (controller.selectedCategory.isNotEmpty || controller.textSearchController.text.isNotEmpty) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const Text('ตัวกรอง: '),
                        if (controller.selectedCategory.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Chip(
                              label: Text('หมวดหมู่: ${controller.getCategoryName(controller.selectedCategory)}'),
                              onDeleted: () => controller.clearCategoryFilter(),
                            ),
                          ),
                        if (controller.textSearchController.text.isNotEmpty)
                          Chip(
                            label: Text('ค้นหา: ${controller.textSearchController.text}'),
                            onDeleted: () => controller.clearSearch(),
                          ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
            
            // Search Results
            Expanded(
              child: Obx(() {
                print('🔍 SearchPage: Search Results Obx - isLoading = ${controller.isLoading}, searchResults.length = ${controller.searchResults.length}');
                
                if (controller.isLoading) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_outlined,
                          size: 80,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'กำลังค้นหา...',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                
                if (controller.searchResults.isEmpty) {
                  return _buildEmptyState(controller);
                }
                
                return controller.isGridView
                    ? ProductGridView(
                        products: controller.searchResults,
                        isLoading: controller.isLoading,
                        onRefresh: () => controller.refreshSearch(),
                      )
                    : ProductListView(
                        products: controller.searchResults,
                        isLoading: controller.isLoading,
                        onRefresh: () => controller.refreshSearch(),
                      );
              }),
            ),
          ],
        ),
        ),
      );
  }

  Widget _buildEmptyState(ProductSearchController controller) {
    if (controller.textSearchController.text.isEmpty && controller.selectedCategory.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'ค้นหาสินค้าที่คุณต้องการ',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'พิมพ์ชื่อสินค้าหรือเลือกหมวดหมู่เพื่อเริ่มค้นหา',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'ไม่พบสินค้าที่ตรงกับการค้นหาของคุณ',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'ลองเปลี่ยนคำค้นหาหรือเลือกหมวดหมู่อื่น',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => controller.clearAllFilters(),
              icon: const Icon(Icons.refresh),
              label: const Text('ล้างตัวกรอง'),
            ),
          ],
        ),
      );
    }
  }
}