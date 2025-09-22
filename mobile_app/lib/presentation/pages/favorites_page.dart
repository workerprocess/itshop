import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/domain/entities/product.dart';
import 'package:mobile_app/presentation/controllers/favorites_controller.dart';
import 'package:mobile_app/presentation/widgets/product_grid_view.dart';
import 'package:mobile_app/presentation/widgets/product_list_view.dart';
import 'package:mobile_app/presentation/widgets/glass/glass_app_bar.dart';
import 'package:mobile_app/presentation/widgets/glass/glass_container.dart';

class FavoritesPage extends GetView<FavoritesController> {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: 'Favorites',
        actions: [
          // View Mode Toggle
          Obx(() => IconButton(
            icon: Icon(
              controller.isGridView ? Icons.list : Icons.grid_view,
            ),
            onPressed: () => controller.toggleViewMode(),
          )),
          // Clear All Button
          Obx(() => controller.favoriteProducts.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear_all),
                  onPressed: () => _showClearAllDialog(context, controller),
                )
              : const SizedBox.shrink()),
          // Settings
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Get.toNamed('/settings'),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight),
            child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_outlined,
                  size: 80,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'กำลังโหลดรายการโปรด...',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
              ),
            ],
          ),
          ),
        );
      }
      
      if (controller.favoriteProducts.isEmpty) {
        return Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight),
          child: _buildEmptyState(),
        );
      }
      
      return Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight),
        child: Column(
          children: [
            // Favorites Count
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GlassContainer(
                padding: const EdgeInsets.all(16),
                child: Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.red[400],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${controller.favoriteProducts.length} รายการโปรด',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => controller.toggleViewMode(),
                    child: Text(
                      controller.isGridView ? 'แสดงแบบรายการ' : 'แสดงแบบกริด',
                    ),
                  ),
                ],
              ),
              ),
            ),
            
            // Favorites List/Grid
            Expanded(
              child: controller.isGridView
                  ? ProductGridView(
                      products: controller.favoriteProducts,
                      isLoading: controller.isLoading,
                      onRefresh: () => controller.loadFavorites(),
                    )
                  : ProductListView(
                      products: controller.favoriteProducts,
                      isLoading: controller.isLoading,
                      onRefresh: () => controller.loadFavorites(),
                    ),
            ),
          ],
        ),
        );
      }),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'ยังไม่มีสินค้าที่บันทึกไว้',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'เพิ่มสินค้าที่คุณชอบลงรายการโปรด',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Get.toNamed('/products'),
            icon: const Icon(Icons.shopping_bag),
            label: const Text('ดูสินค้า'),
          ),
        ],
      ),
    );
  }

  void _showClearAllDialog(BuildContext context, FavoritesController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ล้างรายการโปรด'),
          content: const Text('คุณต้องการลบสินค้าทั้งหมดออกจากรายการโปรดหรือไม่?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('ยกเลิก'),
            ),
            TextButton(
              onPressed: () {
                controller.clearAllFavorites();
                Navigator.of(context).pop();
              },
              child: const Text('ลบทั้งหมด'),
            ),
          ],
        );
      },
    );
  }
}