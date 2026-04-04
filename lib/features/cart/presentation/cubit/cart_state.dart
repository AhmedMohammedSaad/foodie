import 'package:equatable/equatable.dart';
import '../../domain/entities/cart_item_entity.dart';

enum CartStatus { initial, loading, success, error }

class CartState extends Equatable {
  final CartStatus status;
  final List<CartItemEntity> items;
  final String? errorMessage;

  const CartState({
    this.status = CartStatus.initial,
    this.items = const [],
    this.errorMessage,
  });

  CartState copyWith({
    CartStatus? status,
    List<CartItemEntity>? items,
    String? errorMessage,
  }) {
    return CartState(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  int get totalItems => items.fold(0, (total, item) => total + item.quantity);
  double get totalPrice => items.fold(0.0, (total, item) => total + item.totalPrice);

  @override
  List<Object?> get props => [status, items, errorMessage];
}
