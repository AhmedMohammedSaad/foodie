import 'package:equatable/equatable.dart';
import '../../domain/entities/restaurant_details_entity.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();

  @override
  List<Object?> get props => [];
}

class RestaurantInitial extends RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantSuccess extends RestaurantState {
  final RestaurantDetailsEntity restaurant;
  final String selectedCategory;

  const RestaurantSuccess({
    required this.restaurant,
    required this.selectedCategory,
  });

  RestaurantSuccess copyWith({
    RestaurantDetailsEntity? restaurant,
    String? selectedCategory,
  }) {
    return RestaurantSuccess(
      restaurant: restaurant ?? this.restaurant,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [restaurant, selectedCategory];
}

class RestaurantError extends RestaurantState {
  final String message;

  const RestaurantError(this.message);

  @override
  List<Object?> get props => [message];
}
