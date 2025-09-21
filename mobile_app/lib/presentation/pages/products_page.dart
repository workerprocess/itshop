import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/presentation/controllers/products_controller.dart';
import 'package:mobile_app/presentation/widgets/product_grid_view.dart';
import 'package:mobile_app/presentation/widgets/product_list_view.dart';
import 'package:mobile_app/presentation/widgets/glass/glass_app_bar.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductsController>();
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: 'Products',
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
      body: Obx(() {
        if (controller.isLoading) {
          return Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight),
            child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inventory_outlined,
                  size: 80,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'กำลังโหลดสินค้า...',
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
      
      if (controller.products.isEmpty) {
        return Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inventory_2_outlined,
                  size: 80,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'ยังไม่มีสินค้า',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'กำลังเตรียมสินค้าให้คุณ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          );
        }
        
        return Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight),
          child: controller.isGridView
            ? ProductGridView(
                products: controller.products,
                isLoading: controller.isLoading,
                onRefresh: () => controller.refreshProducts(),
              )
            : ProductListView(
                products: controller.products,
                isLoading: controller.isLoading,
                onRefresh: () => controller.refreshProducts(),
              ),
        );
      }),
    );
  }
}
