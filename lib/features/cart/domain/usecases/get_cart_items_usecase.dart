import '../../../../core/models/api_result.dart';
import '../entities/cart_item_entity.dart';
import '../repositories/cart_repository.dart';

class GetCartItemsUseCase {
  final CartRepository repository;

  GetCartItemsUseCase(this.repository);

  Future<ApiResult<List<CartItemEntity>>> execute() async {
    return await repository.getCartItems();
  }
}
