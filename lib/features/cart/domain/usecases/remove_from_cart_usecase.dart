import '../../../../core/models/api_result.dart';
import '../repositories/cart_repository.dart';

class RemoveFromCartUseCase {
  final CartRepository repository;

  RemoveFromCartUseCase(this.repository);

  Future<ApiResult<void>> execute(String cartItemId) async {
    return await repository.removeFromCart(cartItemId);
  }
}
