import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/domain/usecases/get_home_data_usecase.dart';
import '../../../home/domain/entities/restaurant_entity.dart';
import '../../../restaurant/domain/usecases/toggle_restaurant_favorite_usecase.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetHomeDataUseCase getHomeDataUseCase;
  final ToggleRestaurantFavoriteUseCase toggleRestaurantFavoriteUseCase;

  ProfileCubit(this.getHomeDataUseCase, this.toggleRestaurantFavoriteUseCase) : super(ProfileInitial()) {
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
      emit(currentState.copyWith(isLoadingFavorites: true));
      
      final result = await getHomeDataUseCase.execute();
      
      result.fold(
        (data) {
          // Filter restaurants based on real favoriteIds from Supabase
          final favorites = data.restaurants.where((r) => data.favoriteIds.contains(r.id)).toList();
          emit(currentState.copyWith(favorites: favorites, isLoadingFavorites: false));
        },
        (failure) {
          emit(currentState.copyWith(isLoadingFavorites: false));
          // Emit error via a separate UI mechanism or hold in state. 
        },
      );
    }
  }

  Future<void> toggleFavorite(String restaurantId) async {
    final currentState = state;
    if (currentState is ProfileSuccess) {
      final updatedFavorites = List<RestaurantEntity>.from(currentState.favorites);
      final index = updatedFavorites.indexWhere((r) => r.id == restaurantId);
      
      RestaurantEntity? removedRestaurant;
      if (index != -1) {
        removedRestaurant = updatedFavorites.removeAt(index);
      } else {
        // Since we are primarily removing from favorites tab, if it's not and we are adding, 
        // we'd need to fetch its details, but profile mostly removes. Let's just remove it for now.
      }
      
      // Optimistic update
      emit(currentState.copyWith(favorites: updatedFavorites));

      // Sync with DB
      final result = await toggleRestaurantFavoriteUseCase(restaurantId);
      result.fold(
        (_) => null, // Success
        (failure) {
          // Revert on failure
          if (removedRestaurant != null) {
             updatedFavorites.insert(index, removedRestaurant);
             emit(currentState.copyWith(favorites: updatedFavorites));
          }
        },
      );
    }
  }
}
