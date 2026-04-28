import '../../../../core/errors/exceptions.dart';
import '../../../../core/models/api_result.dart';
import '../../../../core/models/failure.dart';
import '../../domain/repositories/checkout_repository.dart';
import '../datasources/checkout_remote_data_source.dart';
import '../models/checkout_payment_intent_model.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutRemoteDataSource remoteDataSource;

  CheckoutRepositoryImpl(this.remoteDataSource);

  @override
  Future<ApiResult<CheckoutPaymentIntentModel>> createPaymentIntent({
    required List<Map<String, dynamic>> items,
    required String restaurantId,
    required String userId,
  }) async {
    try {
      final result = await remoteDataSource.createPaymentIntent(
        items: items,
        restaurantId: restaurantId,
        userId: userId,
      );
      return ApiResult.success(result);
    } on ServerException catch (e) {
      return ApiResult.failure(Failure(message: e.message));
    } catch (e) {
      return ApiResult.failure(const Failure(message: "An unexpected error occurred"));
    }
  }
}
