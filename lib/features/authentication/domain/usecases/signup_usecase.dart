import '../../../../core/models/api_result.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignupUseCase {
  final AuthRepository repository;
  SignupUseCase(this.repository);

  Future<ApiResult<UserEntity>> execute(String email, String password, String name) {
    return repository.signup(email, password, name);
  }
}
