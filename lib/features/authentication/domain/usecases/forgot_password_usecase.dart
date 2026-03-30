import '../../../../core/models/api_result.dart';
import '../repositories/auth_repository.dart';

class ForgotPasswordUseCase {
  final AuthRepository repository;
  ForgotPasswordUseCase(this.repository);

  Future<ApiResult<void>> execute(String email) {
    return repository.forgotPassword(email);
  }
}
