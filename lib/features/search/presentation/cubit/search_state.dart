part of 'search_cubit.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<SearchItemEntity> mockResults;

  SearchLoaded({required this.mockResults});
}

class SearchEmpty extends SearchState {}
