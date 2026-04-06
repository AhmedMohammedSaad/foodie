import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_cart_items_usecase.dart';
import '../../domain/usecases/add_to_cart_usecase.dart';
import '../../domain/usecases/remove_from_cart_usecase.dart';
import '../../domain/usecases/clear_cart_usecase.dart';
import '../../domain/entities/cart_item_entity.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartItemsUseCase getCartItemsUseCase;
  final AddToCartUseCase addToCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final ClearCartUseCase clearCartUseCase;

  CartCubit({
    required this.getCartItemsUseCase,
    required this.addToCartUseCase,
    required this.removeFromCartUseCase,
    required this.clearCartUseCase,
  }) : super(const CartState()) {
    loadCart();
  }

  Future<void> loadCart() async {
    emit(state.copyWith(status: CartStatus.loading));
    final result = await getCartItemsUseCase.execute();
    result.fold(
      (items) => emit(state.copyWith(status: CartStatus.success, items: items)),
      (failure) => emit(state.copyWith(status: CartStatus.error, errorMessage: failure.message)),
    );
  }

  Future<void> addToCart(String foodId, int quantity, {CartItemEntity? existingItem}) async {
    if (existingItem != null) {
      // Optimistic update
      final newItems = List<CartItemEntity>.from(state.items);
      final index = newItems.indexWhere((i) => i.id == existingItem.id);
      if (index != -1) {
        final newQuantity = newItems[index].quantity + quantity;
        if (newQuantity <= 0) {
          newItems.removeAt(index);
        } else {
          newItems[index] = newItems[index].copyWith(quantity: newQuantity);
        }
        emit(state.copyWith(items: newItems));
      }
    }

    final result = await addToCartUseCase.execute(foodId, quantity);
    result.fold(
      (_) {
        if (existingItem == null) loadCart();
      },
      (failure) {
        emit(state.copyWith(status: CartStatus.error, errorMessage: failure.message));
        loadCart(); // Rollback
      },
    );
  }

  Future<void> removeFromCart(String cartItemId) async {
    // Optimistic update
    final previousItems = state.items;
    final newItems = state.items.where((i) => i.id != cartItemId).toList();
    emit(state.copyWith(items: newItems));

    final result = await removeFromCartUseCase.execute(cartItemId);
    result.fold(
      (_) {},
      (failure) {
        emit(state.copyWith(status: CartStatus.error, errorMessage: failure.message, items: previousItems));
        loadCart(); // Rollback
      },
    );
  }

  Future<void> clearCart() async {
    final result = await clearCartUseCase.execute();
    result.fold(
      (_) => emit(state.copyWith(status: CartStatus.success, items: [])),
      (failure) => emit(state.copyWith(status: CartStatus.error, errorMessage: failure.message)),
    );
  }

  int get totalItems => state.items.fold(0, (total, item) => total + item.quantity);
  double get totalPrice => state.items.fold(0.0, (total, item) => total + item.totalPrice);
}
