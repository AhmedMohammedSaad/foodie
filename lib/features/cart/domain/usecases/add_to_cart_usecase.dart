import '../../../../core/models/api_result.dart';
import '../repositories/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository repository;

  AddToCartUseCase(this.repository);

  Future<ApiResult<void>> execute(String foodId, int quantity) async {
    return await repository.addToCart(foodId, quantity);
  }
}
