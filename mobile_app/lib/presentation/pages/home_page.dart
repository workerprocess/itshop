import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/presentation/controllers/home_controller.dart';
import 'package:mobile_app/presentation/widgets/product_card.dart';
import 'package:mobile_app/presentation/widgets/glass/glass_app_bar.dart';
import 'package:mobile_app/presentation/widgets/glass/glass_card.dart';
import 'package:mobile_app/presentation/widgets/glass/glass_container.dart';
import 'package:mobile_app/core/themes/glass_theme.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: GlassAppBar(
          title: 'IT Shop',
          actions: [
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
                    Icons.home_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'กำลังเตรียมข้อมูลสำหรับคุณ',
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
        
        return Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight),
            child: RefreshIndicator(
            onRefresh: () => controller.refreshData(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Membership / Rewards (Glass)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: const Text(
                      'สมาชิก/รีวอร์ด',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Builder(
                      builder: (context) {
                        final glass = Theme.of(context).extension<GlassTheme>()!;
                        final status = controller.membershipStatus;
                        final int points = status?.points ?? 0;
                        final int nextTierPoints = status?.nextTierPoints ?? 1;
                        final String tier = status?.tier ?? '-';
                        final double progress = points / (nextTierPoints == 0 ? 1 : nextTierPoints);
                        return GlassContainer(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.emoji_events, color: glass.borderColor),
                                  const SizedBox(width: 8),
                                  Text('ระดับ: $tier', style: const TextStyle(fontWeight: FontWeight.w600)),
                                  const Spacer(),
                                  Text(
                                    '$points/$nextTierPoints คะแนน',
                                    style: TextStyle(color: glass.borderColor),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: LinearProgressIndicator(
                                  value: progress.clamp(0.0, 1.0),
                                  minHeight: 8,
                                  backgroundColor: glass.borderColor.withOpacity(0.15),
                                  valueColor: AlwaysStoppedAnimation<Color>(glass.borderColor),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Icon(Icons.card_giftcard, size: 18, color: glass.borderColor.withOpacity(0.9)),
                                  const SizedBox(width: 6),
                                  Text(
                                    'แลกคูปองพิเศษได้เมื่อเป็น Silver',
                                    style: TextStyle(color: glass.borderColor.withOpacity(0.9)),
                                  ),
                                  const Spacer(),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text('แลกรีวอร์ด'),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // Continue from last usage (Glass)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: const Text(
                      'ต่อเนื่องจากการใช้งานล่าสุด',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GlassContainer(
                      padding: const EdgeInsets.all(12),
                      child: Builder(
                        builder: (context) {
                          final items = controller.recentViewed.isNotEmpty
                              ? controller.recentViewed
                              : controller.recommendedProducts.take(4).toList();
                          if (items.isEmpty) {
                            return Row(
                              children: const [
                                Icon(Icons.history, color: Colors.grey),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'ยังไม่มีรายการล่าสุด ลองดูสินค้าแนะนำก่อน',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ],
                            );
                          }
                          return SizedBox(
                            height: 220,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: items.length,
                              separatorBuilder: (_, __) => const SizedBox(width: 12),
                              itemBuilder: (context, i) {
                                final item = items[i];
                                return SizedBox(
                                  width: 150,
                                  child: InkWell(
                                    onTap: () => Get.toNamed('/product-detail', arguments: item),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 1,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.network(
                                              item.images.isNotEmpty ? item.images.first : '',
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, _, __) => const ColoredBox(
                                                color: Colors.black12,
                                                child: Center(child: Icon(Icons.image_not_supported)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          item.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          item.category,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  
                  // Recommended Products Section
                  if (controller.recommendedProducts.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'สินค้าแนะนำ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () => Get.toNamed('/products'),
                            child: const Text('ดูทั้งหมด'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 280,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: controller.recommendedProducts.length,
                        itemBuilder: (context, index) {
                          final product = controller.recommendedProducts[index];
                          return Container(
                            width: 160,
                            margin: const EdgeInsets.only(right: 12),
                            child: ProductCard(
                              product: product,
                              onTap: () => Get.toNamed('/product-detail', arguments: product),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                  
                  // Best Seller Products Section
                  if (controller.bestSellerProducts.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'สินค้าขายดี',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () => Get.toNamed('/products'),
                            child: const Text('ดูทั้งหมด'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 280,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: controller.bestSellerProducts.length,
                        itemBuilder: (context, index) {
                          final product = controller.bestSellerProducts[index];
                          return Container(
                            width: 160,
                            margin: const EdgeInsets.only(right: 12),
                            child: ProductCard(
                              product: product,
                              onTap: () => Get.toNamed('/product-detail', arguments: product),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
        ));
      }),
    );
  }
}
