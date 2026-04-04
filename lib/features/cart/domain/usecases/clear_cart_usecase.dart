import '../../../../core/models/api_result.dart';
import '../repositories/cart_repository.dart';

class ClearCartUseCase {
  final CartRepository repository;

  ClearCartUseCase(this.repository);

  Future<ApiResult<void>> execute() async {
    return await repository.clearCart();
  }
}
