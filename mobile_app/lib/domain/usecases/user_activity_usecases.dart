import 'package:mobile_app/domain/entities/membership_status.dart';
import 'package:mobile_app/domain/entities/product.dart';
import 'package:mobile_app/domain/repositories/user_activity_repository.dart';

class GetMembershipStatusUseCase {
  final UserActivityRepository _repository;

  GetMembershipStatusUseCase(this._repository);

  Future<MembershipStatus> call() async {
    return await _repository.getMembershipStatus();
  }
}

class GetRecentViewedProductsUseCase {
  final UserActivityRepository _repository;

  GetRecentViewedProductsUseCase(this._repository);

  Future<List<Product>> call({int limit = 2}) async {
    return await _repository.getRecentViewedProducts(limit: limit);
  }
}

class RecordProductViewedUseCase {
  final UserActivityRepository _repository;

  RecordProductViewedUseCase(this._repository);

  Future<void> call(String productId) async {
    return await _repository.recordProductViewed(productId);
  }
}


