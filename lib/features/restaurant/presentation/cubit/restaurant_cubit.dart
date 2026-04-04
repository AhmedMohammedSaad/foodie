import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_restaurant_details_usecase.dart';
import '../../domain/usecases/toggle_restaurant_favorite_usecase.dart';
import 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  final GetRestaurantDetailsUseCase getRestaurantDetailsUseCase;
  final ToggleRestaurantFavoriteUseCase toggleRestaurantFavoriteUseCase;

  RestaurantCubit(
    this.getRestaurantDetailsUseCase,
    this.toggleRestaurantFavoriteUseCase,
  ) : super(RestaurantInitial());

  Future<void> getRestaurantDetails(String id) async {
    emit(RestaurantLoading());
    final result = await getRestaurantDetailsUseCase.execute(id);

    result.fold(
      (details) {
        final foodCategories = details.foods.map((e) => e.category).where((c) => c.isNotEmpty).toSet().toList();
        final fallbackCategories = details.categories;
        final initialTab = foodCategories.isNotEmpty 
            ? foodCategories.first 
            : (fallbackCategories.isNotEmpty ? fallbackCategories.first : '');

        emit(
          RestaurantSuccess(
            restaurant: details,
            selectedCategory: initialTab,
          ),
        );
      },
      (failure) {
        print(failure.message);
        emit(RestaurantError(failure.message));
      },
    );
  }

  void selectCategory(String category) {
    if (state is RestaurantSuccess) {
      emit((state as RestaurantSuccess).copyWith(selectedCategory: category));
    }
  }

  Future<void> toggleFavorite() async {
    if (state is RestaurantSuccess) {
      final successState = state as RestaurantSuccess;
      final restaurant = successState.restaurant;

      final result = await toggleRestaurantFavoriteUseCase(restaurant.id);

      result.fold(
        (isFavorite) {
          emit(
            successState.copyWith(
              restaurant: restaurant.copyWith(isFavorite: isFavorite),
            ),
          );
        },
        (failure) {
          // You might want to show a toast here
          print(failure.message);
        },
      );
    }
  }
}
