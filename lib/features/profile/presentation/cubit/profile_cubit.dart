import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/domain/usecases/get_home_data_usecase.dart';
import '../../../home/domain/entities/restaurant_entity.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetHomeDataUseCase getHomeDataUseCase;

  ProfileCubit(this.getHomeDataUseCase) : super(ProfileInitial()) {
    // Initial state with index 0
    emit(const ProfileSuccess(selectedIndex: 0));
  }

  void changeTab(int index) async {
    final currentState = state;
    if (currentState is ProfileSuccess) {
      emit(currentState.copyWith(selectedIndex: index));
      
      if (index == 1) {
        // Fetch favorites when switching to favorites tab
        await getFavorites();
      }
    }
  }

  Future<void> getFavorites() async {
    final currentState = state;
    if (currentState is ProfileSuccess) {
      // For now, we fetch all restaurants and mock the "favorite" filter
      final result = await getHomeDataUseCase.execute();
      
      result.fold(
        (data) {
          // Mock filtering logic: restaurants with IDs 1 and 3 are favorites
          final favorites = data.restaurants.where((r) => ['1', '3'].contains(r.id)).toList();
          emit(currentState.copyWith(favorites: favorites));
        },
        (failure) {
          emit(ProfileError(failure.message));
        },
      );
    }
  }

  void toggleFavorite(String restaurantId) {
    final currentState = state;
    if (currentState is ProfileSuccess) {
      final updatedFavorites = List<RestaurantEntity>.from(currentState.favorites);
      final index = updatedFavorites.indexWhere((r) => r.id == restaurantId);
      
      if (index != -1) {
        updatedFavorites.removeAt(index);
      } else {
        // Re-fetch or handle if needed
      }
      
      emit(currentState.copyWith(favorites: updatedFavorites));
    }
  }
}
