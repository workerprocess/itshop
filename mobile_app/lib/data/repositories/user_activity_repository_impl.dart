import 'package:mobile_app/domain/entities/membership_status.dart';
import 'package:mobile_app/domain/entities/product.dart';
import 'package:mobile_app/domain/repositories/user_activity_repository.dart';
import 'package:mobile_app/domain/repositories/product_repository.dart';

class UserActivityRepositoryImpl implements UserActivityRepository {
  final ProductRepository _productRepository;

  UserActivityRepositoryImpl(this._productRepository);

  @override
  Future<MembershipStatus> getMembershipStatus() async {
    // Mock data
    return const MembershipStatus(tier: 'Bronze', points: 120, nextTierPoints: 200);
  }

  @override
  Future<List<Product>> getRecentViewedProducts({int limit = 2}) async {
    // Mock: use first N recommended products as recent
    final products = await _productRepository.getRecommendedProducts();
    return products.take(limit).toList();
  }
}


