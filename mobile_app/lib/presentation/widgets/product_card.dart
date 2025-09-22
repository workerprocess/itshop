import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:mobile_app/domain/entities/product.dart';
import 'package:mobile_app/core/themes/glass_theme.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.white.withOpacity(0.2),
        highlightColor: Colors.white.withOpacity(0.1),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Expanded(
                flex:  2, // รูปภาพได้พื้นที่ 2 ส่วน
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    color: Colors.grey[200],
                  ),
                  child: product.images.isNotEmpty
                      ? ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.network(
                            product.images.first,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.image_not_supported,
                                size: 50,
                                color: Colors.grey,
                              );
                            },
                          ),
                        )
                      : const Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey,
                        ),
                ),
              ),
              
              // Product Info
              Flexible(  // ข้อมูลสินค้าได้พื้นที่ที่เหลือ
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(12),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.2),
                            Colors.white.withOpacity(0.1),
                          ],
                        ),
                        border: Border(
                          top: BorderSide(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Product Name
                      Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      // const SizedBox(height: 2),
                      
                      // Brand
                      Text(
                        product.brand,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white.withOpacity(0.7),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      // const SizedBox(height: 4),
                      
                      // Price and Rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              '฿${product.price.toStringAsFixed(0)}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[300],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star,
                                size: 12,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                product.rating.toString(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // Badges
          // if (product.isRecommended || product.isBestSeller)
          //   Positioned(
          //     top: 8,
          //     right: 8,
          //     child: Row(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         if (product.isRecommended)
          //           Container(
          //             padding: const EdgeInsets.symmetric(
          //               horizontal: 6,
          //               vertical: 2,
          //             ),
          //             decoration: BoxDecoration(
          //               color: Colors.blue,
          //               borderRadius: BorderRadius.circular(8),
          //             ),
          //             child: const Text(
          //               'แนะนำ',
          //               style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 10,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //           ),
          //         if (product.isRecommended && product.isBestSeller)
          //           const SizedBox(width: 4),
          //         if (product.isBestSeller)
          //           Container(
          //             padding: const EdgeInsets.symmetric(
          //               horizontal: 6,
          //               vertical: 2,
          //             ),
          //             decoration: BoxDecoration(
          //               color: Colors.red,
          //               borderRadius: BorderRadius.circular(8),
          //             ),
          //             child: const Text(
          //               'ขายดี',
          //               style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 10,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //           ),
          //       ],
          //     ),
          //   ),
        ],
      ),
      ),
    );
  }
}
