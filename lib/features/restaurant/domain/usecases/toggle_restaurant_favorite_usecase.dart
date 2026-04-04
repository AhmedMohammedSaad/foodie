import '../../../../core/models/api_result.dart';
import '../repositories/restaurant_repository.dart';

class ToggleRestaurantFavoriteUseCase {
  final RestaurantRepository repository;

  ToggleRestaurantFavoriteUseCase(this.repository);

  Future<ApiResult<bool>> call(String restaurantId) {
    return repository.toggleFavorite(restaurantId);
  }
}
