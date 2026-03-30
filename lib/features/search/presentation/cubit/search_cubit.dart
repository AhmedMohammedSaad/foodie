import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/search_item_entity.dart';
import '../../data/datasources/search_local_datasource.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchLocalDataSource _dataSource;

  SearchCubit(this._dataSource) : super(SearchInitial());

  void search(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }
    
    emit(SearchLoading());
    
    final results = await _dataSource.search(query);
    if (results.isEmpty) {
      emit(SearchEmpty());
    } else {
      emit(SearchLoaded(mockResults: results));
    }
  }
}
