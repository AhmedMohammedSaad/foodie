import 'package:equatable/equatable.dart';

enum OrderStatus { 
  pending, 
  confirmed, 
  preparing, 
  onTheWay, 
  delivered, 
  cancelled 
}

class OrderEntity extends Equatable {
  final String id;
  final String restaurantName;
  final String restaurantImage;
  final double totalPrice;
  final int itemsCount;
  final DateTime date;
  final OrderStatus status;

  const OrderEntity({
    required this.id,
    required this.restaurantName,
    required this.restaurantImage,
    required this.totalPrice,
    required this.itemsCount,
    required this.date,
    required this.status,
  });

  String get statusText {
    switch (status) {
      case OrderStatus.pending: return 'Pending';
      case OrderStatus.confirmed: return 'Confirmed';
      case OrderStatus.preparing: return 'Preparing';
      case OrderStatus.onTheWay: return 'On the way';
      case OrderStatus.delivered: return 'Delivered';
      case OrderStatus.cancelled: return 'Cancelled';
    }
  }

  @override
  List<Object?> get props => [
    id, 
    restaurantName, 
    restaurantImage, 
    totalPrice, 
    itemsCount, 
    date, 
    status,
  ];
}
