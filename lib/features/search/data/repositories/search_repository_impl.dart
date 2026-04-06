import '../../../../core/models/api_result.dart';
import '../../domain/entities/search_item_entity.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_remote_data_source.dart';
import '../../../../core/models/failure.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource _remoteDataSource;

  SearchRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<List<SearchItemEntity>>> search(String query) async {
    try {
      final results = await _remoteDataSource.search(query);
      return ApiResult.success(results);
    } catch (e) {
      return ApiResult.failure(Failure(message: e.toString()));
    }
  }
}
