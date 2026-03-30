import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_restaurant_details_usecase.dart';
import 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  final GetRestaurantDetailsUseCase getRestaurantDetailsUseCase;

  RestaurantCubit(this.getRestaurantDetailsUseCase) : super(RestaurantInitial());

  Future<void> getRestaurantDetails(String id) async {
    emit(RestaurantLoading());
    final result = await getRestaurantDetailsUseCase.execute(id);

    result.fold(
      (details) {
        emit(RestaurantSuccess(
          restaurant: details,
          selectedCategory: details.categories.isNotEmpty ? details.categories.first : '',
        ));
      },
      (failure) {
        emit(RestaurantError(failure.message));
      },
    );
  }

  void selectCategory(String category) {
    if (state is RestaurantSuccess) {
      emit((state as RestaurantSuccess).copyWith(selectedCategory: category));
    }
  }

  void toggleFavorite() {
    if (state is RestaurantSuccess) {
      final successState = state as RestaurantSuccess;
      final updatedRestaurant = successState.restaurant.copyWith(
        isFavorite: !successState.restaurant.isFavorite,
      );
      emit(successState.copyWith(restaurant: updatedRestaurant));
    }
  }
}
