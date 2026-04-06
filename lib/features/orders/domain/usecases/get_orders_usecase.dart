import '../../../../core/models/api_result.dart';
import '../entities/order_entity.dart';
import '../repositories/orders_repository.dart';

class GetOrdersUseCase {
  final OrdersRepository repository;

  GetOrdersUseCase(this.repository);

  Future<ApiResult<List<OrderEntity>>> execute() async {
    return await repository.getOrders();
  }
}
