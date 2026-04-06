import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/search_item_entity.dart';
import '../../domain/usecases/search_use_case.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchUseCase _searchUseCase;

  SearchCubit(this._searchUseCase) : super(SearchInitial());

  void search(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }
    
    emit(SearchLoading());
    
    final result = await _searchUseCase.execute(query);
    
    result.fold(
      (results) {
        if (results.isEmpty) {
          emit(SearchEmpty());
        } else {
          emit(SearchLoaded(results: results));
        }
      },
      (failure) {
        emit(SearchError(failure.message));
      },
    );
  }
}
