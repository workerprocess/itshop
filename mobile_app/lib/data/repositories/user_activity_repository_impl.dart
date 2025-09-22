import 'package:mobile_app/domain/entities/membership_status.dart';
import 'package:mobile_app/domain/entities/product.dart';
import 'package:mobile_app/domain/repositories/user_activity_repository.dart';
import 'package:mobile_app/domain/repositories/product_repository.dart';
import 'package:mobile_app/data/datasources/local/recent_storage.dart';

class UserActivityRepositoryImpl implements UserActivityRepository {
  final ProductRepository _productRepository;
  final RecentStorage _recentStorage;

  UserActivityRepositoryImpl(this._productRepository, {RecentStorage? recentStorage})
      : _recentStorage = recentStorage ?? RecentStorage();

  @override
  Future<MembershipStatus> getMembershipStatus() async {
    // Mock data
    return const MembershipStatus(tier: 'Bronze', points: 120, nextTierPoints: 200);
  }

  @override
  Future<List<Product>> getRecentViewedProducts({int limit = 2}) async {
    final ids = await _recentStorage.getRecentIds();
    if (ids.isEmpty) {
      // Fallback: first N recommended products
      final products = await _productRepository.getRecommendedProducts();
      return products.take(limit).toList();
    }
    final List<Product> collected = [];
    for (final id in ids) {
      try {
        final p = await _productRepository.getProductById(id);
        collected.add(p);
        if (collected.length >= limit) break;
      } catch (_) {}
    }
    return collected;
  }

  @override
  Future<void> recordProductViewed(String productId) async {
    await _recentStorage.addRecentId(productId);
  }
}


