import 'package:equatable/equatable.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/restaurant_entity.dart';

enum HomeFilterType {
  none,
  priceLowToHigh,
  priceHighToLow,
  nearest,
  farthest,
}

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<CategoryEntity> categories;
  final List<RestaurantEntity> restaurants;
  final List<RestaurantEntity> filteredRestaurants;
  final String? selectedCategoryId;
  final String searchQuery;
  final HomeFilterType filterType;
  final List<String> favoriteIds;

  const HomeSuccess({
    required this.categories,
    required this.restaurants,
    required this.filteredRestaurants,
    this.selectedCategoryId,
    this.searchQuery = '',
    this.filterType = HomeFilterType.none,
    this.favoriteIds = const [],
  });

  HomeSuccess copyWith({
    List<CategoryEntity>? categories,
    List<RestaurantEntity>? restaurants,
    List<RestaurantEntity>? filteredRestaurants,
    String? selectedCategoryId,
    String? searchQuery,
    HomeFilterType? filterType,
    List<String>? favoriteIds,
    bool clearCategory = false,
  }) {
    return HomeSuccess(
      categories: categories ?? this.categories,
      restaurants: restaurants ?? this.restaurants,
      filteredRestaurants: filteredRestaurants ?? this.filteredRestaurants,
      selectedCategoryId: clearCategory ? null : (selectedCategoryId ?? this.selectedCategoryId),
      searchQuery: searchQuery ?? this.searchQuery,
      filterType: filterType ?? this.filterType,
      favoriteIds: favoriteIds ?? this.favoriteIds,
    );
  }

  @override
  List<Object?> get props => [
        categories,
        restaurants,
        filteredRestaurants,
        selectedCategoryId,
        searchQuery,
        filterType,
        favoriteIds,
      ];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
