import '../../../../core/models/api_result.dart';
import '../entities/order_entity.dart';

abstract class OrdersRepository {
  Future<ApiResult<List<OrderEntity>>> getOrders();
}
