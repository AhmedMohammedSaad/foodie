import '../../../../core/networking/api_consumer.dart';
import '../../../../core/utils/app_constants.dart';
import '../models/checkout_payment_intent_model.dart';

abstract class CheckoutRemoteDataSource {
  Future<CheckoutPaymentIntentModel> createPaymentIntent({
    required List<Map<String, dynamic>> items,
    required String restaurantId,
    required String userId,
  });
}

class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSource {
  final ApiConsumer api;

  CheckoutRemoteDataSourceImpl(this.api);

  @override
  Future<CheckoutPaymentIntentModel> createPaymentIntent({
    required List<Map<String, dynamic>> items,
    required String restaurantId,
    required String userId,
  }) async {
    final response = await api.post(
      '${AppConstants.supabaseUrl}/functions/v1/create-payment-intent',
      data: {
        'items': items,
        'restaurant_id': restaurantId,
        'user_id': userId,
      },
      queryParameters: {
        'apikey': AppConstants.supabaseAnonKey,
      }
    );
    return CheckoutPaymentIntentModel.fromJson(response);
  }
}
