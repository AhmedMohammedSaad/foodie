import '../../../../core/models/api_result.dart';
import '../entities/cart_item_entity.dart';

abstract class CartRepository {
  Future<ApiResult<List<CartItemEntity>>> getCartItems();
  Future<ApiResult<void>> addToCart(String foodId, int quantity);
  Future<ApiResult<void>> removeFromCart(String cartItemId);
  Future<ApiResult<void>> clearCart();
}
