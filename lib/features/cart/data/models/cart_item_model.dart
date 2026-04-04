import '../../domain/entities/cart_item_entity.dart';
import '../../../restaurant/data/models/food_model.dart';

class CartItemModel extends CartItemEntity {
  const CartItemModel({
    required super.id,
    required super.food,
    required super.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id']?.toString() ?? '',
      food: FoodModel.fromJson(json['menu_items'] ?? {}),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'food': (food as FoodModel).toJson(),
      'quantity': quantity,
    };
  }
}
