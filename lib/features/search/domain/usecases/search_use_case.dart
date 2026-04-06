import '../../../../core/models/api_result.dart';
import '../entities/search_item_entity.dart';
import '../repositories/search_repository.dart';

class SearchUseCase {
  final SearchRepository _repository;

  SearchUseCase(this._repository);

  Future<ApiResult<List<SearchItemEntity>>> execute(String query) {
    return _repository.search(query);
  }
}
