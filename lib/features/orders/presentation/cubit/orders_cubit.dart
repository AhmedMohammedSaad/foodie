import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_orders_usecase.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUseCase getOrdersUseCase;

  OrdersCubit(this.getOrdersUseCase) : super(OrdersInitial());

  Future<void> loadOrders() async {
    emit(OrdersLoading());

    final result = await getOrdersUseCase.execute();
    
    result.fold(
      (orders) {
        if (orders.isEmpty) {
          emit(OrdersEmpty());
        } else {
          emit(OrdersSuccess(orders: orders));
        }
      },
      (failure) => emit(OrdersFailure(message: failure.message)),
    );
  }
}
