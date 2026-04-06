import '../../../../core/models/api_result.dart';
import '../../../../core/models/failure.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/orders_repository.dart';
import '../datasources/orders_remote_data_source.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDataSource remoteDataSource;

  OrdersRepositoryImpl(this.remoteDataSource);

  @override
  Future<ApiResult<List<OrderEntity>>> getOrders() async {
    try {
      final models = await remoteDataSource.getOrders();
      return ApiResult.success(models);
    } on ServerException catch (e) {
      return ApiResult.failure(Failure(message: e.message));
    } catch (e) {
      return ApiResult.failure(Failure(message: e.toString()));
    }
  }
}
