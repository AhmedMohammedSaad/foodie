import '../../domain/entities/order_entity.dart';

abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersSuccess extends OrdersState {
  final List<OrderEntity> orders;

  OrdersSuccess({required this.orders});
}

class OrdersFailure extends OrdersState {
  final String message;

  OrdersFailure({required this.message});
}

class OrdersEmpty extends OrdersState {}
