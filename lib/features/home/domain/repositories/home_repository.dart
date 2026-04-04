import '../../../../core/models/api_result.dart';
import '../entities/category_entity.dart';
import '../entities/restaurant_entity.dart';

abstract class HomeRepository {
  Future<ApiResult<List<CategoryEntity>>> getCategories();
  Future<ApiResult<List<RestaurantEntity>>> getPopularRestaurants();
  Future<ApiResult<List<String>>> getFavoriteIds();
}
