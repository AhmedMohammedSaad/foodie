import 'package:equatable/equatable.dart';
import '../../../restaurant/domain/entities/food_entity.dart';

class CartItemEntity extends Equatable {
  final String id;
  final FoodEntity food;
  final int quantity;

  const CartItemEntity({
    required this.id,
    required this.food,
    required this.quantity,
  });

  CartItemEntity copyWith({
    String? id,
    FoodEntity? food,
    int? quantity,
  }) {
    return CartItemEntity(
      id: id ?? this.id,
      food: food ?? this.food,
      quantity: quantity ?? this.quantity,
    );
  }

  double get totalPrice => food.price * quantity;

  @override
  List<Object?> get props => [id, food, quantity];
}

