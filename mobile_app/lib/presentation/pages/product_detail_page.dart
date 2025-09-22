import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:mobile_app/domain/entities/product.dart';
import 'package:mobile_app/presentation/widgets/glass/glass_app_bar.dart';
import 'package:mobile_app/core/themes/glass_theme.dart';
import 'package:mobile_app/presentation/widgets/glass/glass_card.dart';
import 'package:mobile_app/presentation/widgets/glass/glass_container.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassTheme>()!;
    return Container(
      decoration: BoxDecoration(
        gradient: glass.backgroundGradient,
      ),
      child: Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: GlassAppBar(
        title: product.name,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // TODO: Toggle favorite
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Share product
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + kToolbarHeight,
          bottom: 120, // reserve space so content isn't hidden behind glass bar
        ),
        child: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Images
            _buildProductImages(),
            
            // Product Info
            _buildProductInfo(context),
            
            // Specifications
            _buildSpecifications(),
            
            // Reviews Section
            _buildReviewsSection(),
          ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  Widget _buildProductImages() {
    return Container(
      height: 300,
      child: PageView.builder(
        itemCount: product.images.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: product.images.isNotEmpty
                  ? Image.network(
                      product.images[index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 80,
                            color: Colors.grey,
                          ),
                        );
                      },
                    )
                  : Container(
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 80,
                        color: Colors.grey,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductInfo(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Name
          Text(
            product.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Brand
          Text(
            product.brand,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Price and Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(builder: (context) {
                final glass = Theme.of(context).extension<GlassTheme>()!;
                return Text(
                  '฿${product.price.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: glass.priceColor,
                  ),
                );
              }),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 24,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${product.rating} (${product.reviewCount} รีวิว)',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Description
          Text(
            product.description,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Badges
          if (product.isRecommended || product.isBestSeller)
            Row(
              children: [
                if (product.isRecommended)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'สินค้าแนะนำ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                if (product.isRecommended && product.isBestSeller)
                  const SizedBox(width: 8),
                if (product.isBestSeller)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'ขายดี',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSpecifications() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ข้อมูลจำเพาะ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...product.specifications.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120,
                    child: Text(
                      entry.key,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    ));
  }

  Widget _buildReviewsSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'รีวิวสินค้า',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Colors.amber,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                '${product.rating} จาก 5.0',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              Text(
                '${product.reviewCount} รีวิว',
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // TODO: Navigate to reviews page
            },
            child: const Text('ดูรีวิวทั้งหมด'),
          ),
        ],
      ),
    ));
  }

  // Removed related products section as per request

  Widget _buildBottomBar(BuildContext context) {
    final glass = Theme.of(context).extension<GlassTheme>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color labelColor = isDark ? Colors.white : Colors.black87;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: glass.blur, sigmaY: glass.blur),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 92,
            child: Container(
              decoration: BoxDecoration(
                gradient: glass.gradient.scale(glass.opacity),
                border: Border(
                  top: BorderSide(color: glass.borderColor, width: glass.borderWidth),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
              // Add to Cart Button (Glass)
              Expanded(
                flex: 2,
                child: GlassCard(
                  height: 52,
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  onTap: () {
                    // TODO: Add to cart
                    Get.snackbar(
                      'เพิ่มลงตะกร้า',
                      '${product.name} ถูกเพิ่มลงตะกร้าแล้ว',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  child: Center(
                    child: Text(
                      'เพิ่มลงตะกร้า',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: labelColor,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Buy Now Button (Glass)
              Expanded(
                flex: 2,
                child: GlassCard(
                  height: 52,
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  onTap: () {
                    // TODO: Buy now
                    Get.snackbar(
                      'ซื้อทันที',
                      'กำลังดำเนินการซื้อ ${product.name}',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  child: Center(
                    child: Text(
                      'ซื้อทันที',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: labelColor,
                      ),
                    ),
                  ),
                ),
              ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}