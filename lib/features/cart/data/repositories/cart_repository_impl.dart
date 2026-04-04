import '../../../../core/models/api_result.dart';
import '../../../../core/models/failure.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../datasources/cart_remote_data_source.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<List<CartItemEntity>>> getCartItems() async {
    try {
      final items = await remoteDataSource.getCartItems();
      return ApiResult.success(items);
    } catch (e) {
      return ApiResult.failure(Failure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<void>> addToCart(String foodId, int quantity) async {
    try {
      await remoteDataSource.addToCart(foodId, quantity);
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(Failure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<void>> removeFromCart(String cartItemId) async {
    try {
      await remoteDataSource.removeFromCart(cartItemId);
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(Failure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<void>> clearCart() async {
    try {
      await remoteDataSource.clearCart();
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(Failure(message: e.toString()));
    }
  }
}
