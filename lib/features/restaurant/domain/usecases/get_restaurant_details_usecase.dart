import '../../../../core/models/api_result.dart';
import '../repositories/restaurant_repository.dart';
import '../entities/restaurant_details_entity.dart';

class GetRestaurantDetailsUseCase {
  final RestaurantRepository repository;

  GetRestaurantDetailsUseCase(this.repository);

  Future<ApiResult<RestaurantDetailsEntity>> execute(String restaurantId) async {
    return await repository.getRestaurantDetails(restaurantId);
  }
}
