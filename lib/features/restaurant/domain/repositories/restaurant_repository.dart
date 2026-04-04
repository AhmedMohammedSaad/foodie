import '../../../../core/models/api_result.dart';
import '../entities/restaurant_details_entity.dart';

abstract class RestaurantRepository {
  Future<ApiResult<RestaurantDetailsEntity>> getRestaurantDetails(String restaurantId);
  Future<ApiResult<bool>> toggleFavorite(String restaurantId);
}

