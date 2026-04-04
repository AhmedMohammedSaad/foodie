import '../../../../core/models/api_result.dart';
import '../entities/category_entity.dart';
import '../entities/restaurant_entity.dart';
import '../repositories/home_repository.dart';

class GetHomeDataUseCase {
  final HomeRepository repository;

  GetHomeDataUseCase(this.repository);

  Future<ApiResult<({List<CategoryEntity> categories, List<RestaurantEntity> restaurants, List<String> favoriteIds})>> execute() async {
    final categoriesResult = await repository.getCategories();
    final restaurantsResult = await repository.getPopularRestaurants();
    final favoritesResult = await repository.getFavoriteIds();

    return categoriesResult.fold(
      (categories) => restaurantsResult.fold(
        (restaurants) => favoritesResult.fold(
          (favoriteIds) => ApiResult.success((
            categories: categories,
            restaurants: restaurants,
            favoriteIds: favoriteIds,
          )),
          (failure) => ApiResult.failure(failure),
        ),
        (failure) => ApiResult.failure(failure),
      ),
      (failure) => ApiResult.failure(failure),
    );
  }
}
