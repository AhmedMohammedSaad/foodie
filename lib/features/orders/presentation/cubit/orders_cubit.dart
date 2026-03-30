import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/order_entity.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  void loadOrders() {
    emit(OrdersLoading());

    // Simulate network delay
    Future.delayed(const Duration(seconds: 1), () {
      final mockOrders = [
        OrderEntity(
          id: 'ORD-001',
          restaurantName: 'Pizza Hub',
          restaurantImage: 'assets/images/restaurant2.png',
          totalPrice: 25.50,
          itemsCount: 2,
          date: DateTime.now().subtract(const Duration(hours: 2)),
          status: OrderStatus.onTheWay,
        ),
        OrderEntity(
          id: 'ORD-002',
          restaurantName: 'Burger Palace',
          restaurantImage: 'assets/images/restaurant1.png',
          totalPrice: 18.20,
          itemsCount: 3,
          date: DateTime.now().subtract(const Duration(days: 1)),
          status: OrderStatus.delivered,
        ),
        OrderEntity(
          id: 'ORD-003',
          restaurantName: 'Healthy Bites',
          restaurantImage: 'assets/images/restaurant1.png',
          totalPrice: 12.00,
          itemsCount: 1,
          date: DateTime.now().subtract(const Duration(days: 3)),
          status: OrderStatus.cancelled,
        ),
      ];

      if (mockOrders.isEmpty) {
        emit(OrdersEmpty());
      } else {
        emit(OrdersSuccess(orders: mockOrders));
      }
    });
  }
}
