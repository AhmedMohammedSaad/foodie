import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_home_data_usecase.dart';
import '../../domain/entities/restaurant_entity.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeDataUseCase getHomeDataUseCase;

  HomeCubit(this.getHomeDataUseCase) : super(HomeInitial());

  Future<void> getHomeData() async {
    emit(HomeLoading());
    final result = await getHomeDataUseCase.execute();
    result.fold(
      (data) {
        emit(HomeSuccess(
          categories: data.categories,
          restaurants: data.restaurants,
          filteredRestaurants: data.restaurants,
        ));
      },
      (failure) => emit(HomeError(failure.message)),
    );
  }

  void selectCategory(String? categoryId) {
    if (state is HomeSuccess) {
      final successState = state as HomeSuccess;
      final newCategoryId = successState.selectedCategoryId == categoryId ? null : categoryId;
      final newState = successState.copyWith(
        selectedCategoryId: newCategoryId,
        clearCategory: newCategoryId == null,
      );
      emit(newState.copyWith(filteredRestaurants: _applyFilters(newState)));
    }
  }

  void updateSearch(String query) {
    if (state is HomeSuccess) {
      final successState = state as HomeSuccess;
      final newState = successState.copyWith(searchQuery: query);
      emit(newState.copyWith(filteredRestaurants: _applyFilters(newState)));
    }
  }

  void setFilter(HomeFilterType filterType) {
    if (state is HomeSuccess) {
      final successState = state as HomeSuccess;
      final newState = successState.copyWith(filterType: filterType);
      emit(newState.copyWith(filteredRestaurants: _applyFilters(newState)));
    }
  }

  void toggleFavorite(String restaurantId) {
    if (state is HomeSuccess) {
      final successState = state as HomeSuccess;
      final List<String> newFavorites = List.from(successState.favoriteIds);
      if (newFavorites.contains(restaurantId)) {
        newFavorites.remove(restaurantId);
      } else {
        newFavorites.add(restaurantId);
      }
      emit(successState.copyWith(favoriteIds: newFavorites));
    }
  }

  List<RestaurantEntity> _applyFilters(HomeSuccess state) {
    List<RestaurantEntity> filtered = List.from(state.restaurants);

    // 1. Category Filter
    if (state.selectedCategoryId != null) {
      filtered = filtered.where((r) => r.categoryId == state.selectedCategoryId).toList();
    }

    // 2. Search Filter
    if (state.searchQuery.isNotEmpty) {
      final query = state.searchQuery.toLowerCase();
      filtered = filtered.where((r) {
        return r.name.toLowerCase().contains(query) || r.cuisine.toLowerCase().contains(query);
      }).toList();
    }

    // 3. Sorting
    switch (state.filterType) {
      case HomeFilterType.priceLowToHigh:
        filtered.sort((a, b) => a.price.compareTo(b.price));
        break;
      case HomeFilterType.priceHighToLow:
        filtered.sort((a, b) => b.price.compareTo(a.price));
        break;
      case HomeFilterType.nearest:
        filtered.sort((a, b) => a.distance.compareTo(b.distance));
        break;
      case HomeFilterType.farthest:
        filtered.sort((a, b) => b.distance.compareTo(a.distance));
        break;
      case HomeFilterType.none:
        break;
    }

    return filtered;
  }
}
