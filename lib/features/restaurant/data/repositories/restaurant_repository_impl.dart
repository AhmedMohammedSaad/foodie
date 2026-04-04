import '../../../../core/models/api_result.dart';
import '../../../../core/models/failure.dart';
import '../../domain/entities/restaurant_details_entity.dart';
import '../../domain/repositories/restaurant_repository.dart';
import '../datasources/restaurant_remote_data_source.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantRemoteDataSource remoteDataSource;

  RestaurantRepositoryImpl(this.remoteDataSource);

  @override
  Future<ApiResult<RestaurantDetailsEntity>> getRestaurantDetails(String restaurantId) async {
    try {
      final result = await remoteDataSource.getRestaurantDetails(restaurantId);
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(Failure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<bool>> toggleFavorite(String restaurantId) async {
    try {
      final result = await remoteDataSource.toggleFavorite(restaurantId);
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(Failure(message: e.toString()));
    }
  }
}

