import '../../domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.restaurantName,
    required super.restaurantImage,
    required super.totalPrice,
    required super.itemsCount,
    required super.date,
    required super.status,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      restaurantName: json['restaurant_name'] as String? ?? 'Unknown',
      restaurantImage: json['restaurant_image'] as String? ?? '',
      totalPrice: (json['total_price'] as num?)?.toDouble() ?? 0.0,
      itemsCount: json['items_count'] as int? ?? 1,
      date: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
      status: _parseStatus(json['status'] as String?),
    );
  }

  static OrderStatus _parseStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'confirmed': return OrderStatus.confirmed;
      case 'preparing': return OrderStatus.preparing;
      case 'ontheway': return OrderStatus.onTheWay;
      case 'on_the_way': return OrderStatus.onTheWay;
      case 'delivered': return OrderStatus.delivered;
      case 'cancelled': return OrderStatus.cancelled;
      case 'pending': 
      default: return OrderStatus.pending;
    }
  }
}
