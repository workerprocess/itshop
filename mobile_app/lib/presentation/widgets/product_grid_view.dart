import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/domain/entities/product.dart';
import 'package:mobile_app/presentation/widgets/product_card.dart';

class ProductGridView extends StatelessWidget {
  final List<Product> products;
  final VoidCallback? onProductTap;
  final VoidCallback? onFavoriteTap;
  final bool isLoading;
  final VoidCallback? onRefresh;

  const ProductGridView({
    super.key,
    required this.products,
    this.onProductTap,
    this.onFavoriteTap,
    this.isLoading = false,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'ยังไม่มีข้อมูลที่เกี่ยวข้อง',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'กำลังเตรียมสินค้าแนะนำสำหรับคุณ',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRefresh,
              icon: const Icon(Icons.refresh),
              label: const Text('ลองใหม่'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        onRefresh?.call();
      },
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _getCrossAxisCount(context),
          childAspectRatio: 0.5,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            product: product,
            onTap: () {
              onProductTap?.call();
              // TODO: Navigate to product detail
              Get.toNamed('/product-detail', arguments: product);
            },
            onFavoriteTap: () {
              onFavoriteTap?.call();
              // TODO: Toggle favorite
            },
          );
        },
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    // Responsive design based on screen width
    if (width > 1200) {
      return 6; // Desktop
    } else if (width > 800) {
      return 4; // Tablet landscape
    } else if (width > 600) {
      return 3; // Tablet portrait
    } else if (width > 400) {
      return 2; // Large phone
    } else {
      return 2; // Small phone
    }
  }
}
