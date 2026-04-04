import '../../data/models/cart_item_model.dart';

abstract class CartRemoteDataSource {
  Future<List<CartItemModel>> getCartItems();
  Future<void> addToCart(String foodId, int quantity);
  Future<void> removeFromCart(String cartItemId);
  Future<void> clearCart();
}
