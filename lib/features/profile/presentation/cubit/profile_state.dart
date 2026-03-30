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

  const ProfileSuccess({
    this.selectedIndex = 0,
    this.favorites = const [],
  });

  @override
  List<Object?> get props => [selectedIndex, favorites];

  ProfileSuccess copyWith({
    int? selectedIndex,
    List<RestaurantEntity>? favorites,
  }) {
    return ProfileSuccess(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      favorites: favorites ?? this.favorites,
    );
  }
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
