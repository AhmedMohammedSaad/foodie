import '../../../../core/models/api_result.dart';
import '../../data/models/checkout_payment_intent_model.dart';
import '../repositories/checkout_repository.dart';

class InitiateCheckoutUseCase {
  final CheckoutRepository repository;

  InitiateCheckoutUseCase(this.repository);

  Future<ApiResult<CheckoutPaymentIntentModel>> execute({
    required List<Map<String, dynamic>> items,
    required String restaurantId,
    required String userId,
  }) async {
    return await repository.createPaymentIntent(
      items: items,
      restaurantId: restaurantId,
      userId: userId,
    );
  }
}
