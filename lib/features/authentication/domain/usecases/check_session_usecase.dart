import '../../../../core/models/api_result.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class CheckSessionUseCase {
  final AuthRepository _repository;

  CheckSessionUseCase(this._repository);

  Future<ApiResult<UserEntity?>> execute() async {
    return await _repository.getCurrentUser();
  }
}
