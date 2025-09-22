import 'package:mobile_app/domain/entities/membership_status.dart';
import 'package:mobile_app/domain/entities/product.dart';

abstract class UserActivityRepository {
  Future<MembershipStatus> getMembershipStatus();
  Future<List<Product>> getRecentViewedProducts({int limit = 2});
}


