import '../../../../core/models/api_result.dart';
import '../entities/search_item_entity.dart';

abstract class SearchRepository {
  Future<ApiResult<List<SearchItemEntity>>> search(String query);
}
