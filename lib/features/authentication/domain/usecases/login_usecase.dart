import '../../../../core/models/api_result.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  Future<ApiResult<UserEntity>> execute(String email, String password) {
    return repository.login(email, password);
  }
}
