import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:mobile_app/domain/entities/product.dart';
import 'package:mobile_app/core/themes/glass_theme.dart';

class ProductListView extends StatelessWidget {
  final List<Product> products;
  final VoidCallback? onProductTap;
  final VoidCallback? onFavoriteTap;
  final bool isLoading;
  final VoidCallback? onRefresh;

  const ProductListView({
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
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return _buildProductListItem(context, product);
        },
      ),
    );
  }

  Widget _buildProductListItem(BuildContext context, Product product) {
    final glass = Theme.of(context).extension<GlassTheme>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: glass.blur, sigmaY: glass.blur),
          child: Container(
            decoration: BoxDecoration(
              gradient: glass.gradient.scale(glass.opacity),
              border: Border.all(
                color: glass.borderColor,
                width: glass.borderWidth,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () {
                onProductTap?.call();
                Get.toNamed('/product-detail', arguments: product);
              },
              borderRadius: BorderRadius.circular(12),
              splashColor: Colors.white.withOpacity(0.2),
              highlightColor: Colors.white.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    // Product Image
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[200],
                      ),
                      child: product.images.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                product.images.first,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.image_not_supported,
                                    size: 30,
                                    color: Colors.grey,
                                  );
                                },
                              ),
                            )
                          : const Icon(
                              Icons.image_not_supported,
                              size: 30,
                              color: Colors.grey,
                            ),
                    ),
                    
                    const SizedBox(width: 12),
                    
                    // Product Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Name
                          Text(
                            product.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white.withOpacity(0.9) : Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                          const SizedBox(height: 4),
                          
                          // Brand
                          Text(
                            product.brand,
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark ? Colors.white.withOpacity(0.7) : Colors.grey[600],
                            ),
                          ),
                          
                          const SizedBox(height: 8),
                          
                          // Price and Rating
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Builder(builder: (context) {
                                final glass = Theme.of(context).extension<GlassTheme>()!;
                                return Text(
                                  '฿${product.price.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: glass.priceColor,
                                  ),
                                );
                              }),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    product.rating.toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: isDark ? Colors.white.withOpacity(0.9) : Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '(${product.reviewCount})',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark ? Colors.white.withOpacity(0.6) : Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    // Badges and Favorite Button
                    Column(
                      children: [
                        // Badges
                        if (product.isRecommended || product.isBestSeller)
                          Column(
                            children: [
                              if (product.isRecommended)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'แนะนำ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              if (product.isRecommended && product.isBestSeller)
                                const SizedBox(height: 4),
                              if (product.isBestSeller)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'ขายดี',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        
                        const SizedBox(height: 8),
                        
                        // Favorite Button
                        IconButton(
                          onPressed: () {
                            onFavoriteTap?.call();
                          },
                          icon: Icon(
                            Icons.favorite_border,
                            color: isDark ? Colors.white.withOpacity(0.7) : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
