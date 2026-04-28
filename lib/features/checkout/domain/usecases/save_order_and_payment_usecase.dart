import '../../../../core/models/api_result.dart';
import '../repositories/checkout_repository.dart';

class SaveOrderAndPaymentUseCase {
  final CheckoutRepository repository;

  SaveOrderAndPaymentUseCase(this.repository);

  Future<ApiResult<void>> execute({
    required List<Map<String, dynamic>> items,
    required String restaurantId,
    required String userId,
    required double totalPrice,
    required String paymentIntentId,
  }) {
    return repository.saveOrderAndPayment(
      items: items,
      restaurantId: restaurantId,
      userId: userId,
      totalPrice: totalPrice,
      paymentIntentId: paymentIntentId,
    );
  }
}
