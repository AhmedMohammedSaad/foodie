import '../../../../core/models/api_result.dart';
import '../../../../core/models/failure.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/restaurant_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<ApiResult<List<CategoryEntity>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return ApiResult.success(categories);
    } catch (e) {
      return ApiResult.failure(Failure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<List<RestaurantEntity>>> getPopularRestaurants() async {
    try {
      final restaurants = await remoteDataSource.getPopularRestaurants();
      return ApiResult.success(restaurants);
    } catch (e) {
      return ApiResult.failure(Failure(message: e.toString()));
    }
  }
}
