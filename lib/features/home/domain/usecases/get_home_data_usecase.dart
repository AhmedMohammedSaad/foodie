import '../../../../core/models/api_result.dart';
import '../entities/category_entity.dart';
import '../entities/restaurant_entity.dart';
import '../repositories/home_repository.dart';

class GetHomeDataUseCase {
  final HomeRepository repository;

  GetHomeDataUseCase(this.repository);

  Future<ApiResult<({List<CategoryEntity> categories, List<RestaurantEntity> restaurants})>> execute() async {
    final categoriesResult = await repository.getCategories();
    final restaurantsResult = await repository.getPopularRestaurants();

    return categoriesResult.fold(
      (categories) => restaurantsResult.fold(
        (restaurants) => ApiResult.success((categories: categories, restaurants: restaurants)),
        (failure) => ApiResult.failure(failure),
      ),
      (failure) => ApiResult.failure(failure),
    );
  }
}
