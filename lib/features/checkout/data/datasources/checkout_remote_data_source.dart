import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/networking/api_consumer.dart';
import '../../../../core/utils/app_constants.dart';
import '../models/checkout_payment_intent_model.dart';

abstract class CheckoutRemoteDataSource {
  Future<CheckoutPaymentIntentModel> createPaymentIntent({
    required List<Map<String, dynamic>> items,
    required String restaurantId,
    required String userId,
  });

  Future<void> saveOrderAndPayment({
    required List<Map<String, dynamic>> items,
    required String restaurantId,
    required String userId,
    required double totalPrice,
    required String paymentIntentId,
  });
}

class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSource {
  final ApiConsumer api;
  final SupabaseClient supabase;

  CheckoutRemoteDataSourceImpl(this.api, this.supabase);

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

  @override
  Future<void> saveOrderAndPayment({
    required List<Map<String, dynamic>> items,
    required String restaurantId,
    required String userId,
    required double totalPrice,
    required String paymentIntentId,
  }) async {
    // 1. Create Order
    final order = await supabase.from('orders').insert({
      'user_id': userId,
      'restaurant_id': restaurantId,
      'total_price': totalPrice,
      'items_count': items.length,
      'status': 'confirmed',
    }).select().single();

    final orderId = order['id'];

    // 2. Create Order Items
    final orderItems = items.map((item) => {
      'order_id': orderId,
      'food_id': item['food_id'] ?? item['id'],
      'quantity': item['quantity'],
      'price': item['price'],
    }).toList();

    await supabase.from('order_items').insert(orderItems);

    // 3. Create Payment Record
    await supabase.from('payments').insert({
      'user_id': userId,
      'order_id': orderId,
      'stripe_payment_intent_id': paymentIntentId,
      'amount': totalPrice,
      'currency': 'usd',
      'status': 'succeeded',
    });
  }
}
