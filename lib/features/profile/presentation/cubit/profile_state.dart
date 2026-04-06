import 'package:equatable/equatable.dart';
import '../../../home/domain/entities/restaurant_entity.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final int selectedIndex;
  final List<RestaurantEntity> favorites;
  final bool isLoadingFavorites;

  const ProfileSuccess({
    this.selectedIndex = 0,
    this.favorites = const [],
    this.isLoadingFavorites = false,
  });

  @override
  List<Object?> get props => [selectedIndex, favorites, isLoadingFavorites];

  ProfileSuccess copyWith({
    int? selectedIndex,
    List<RestaurantEntity>? favorites,
    bool? isLoadingFavorites,
  }) {
    return ProfileSuccess(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      favorites: favorites ?? this.favorites,
      isLoadingFavorites: isLoadingFavorites ?? this.isLoadingFavorites,
    );
  }
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
