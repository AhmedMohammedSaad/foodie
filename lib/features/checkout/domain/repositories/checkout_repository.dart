import '../../../../core/models/api_result.dart';
import '../../data/models/checkout_payment_intent_model.dart';

abstract class CheckoutRepository {
  Future<ApiResult<CheckoutPaymentIntentModel>> createPaymentIntent({
    required List<Map<String, dynamic>> items,
    required String restaurantId,
    required String userId,
  });

  Future<ApiResult<void>> saveOrderAndPayment({
    required List<Map<String, dynamic>> items,
    required String restaurantId,
    required String userId,
    required double totalPrice,
    required String paymentIntentId,
  });
}
