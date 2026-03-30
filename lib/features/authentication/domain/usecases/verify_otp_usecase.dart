import '../../../../core/models/api_result.dart';
import '../repositories/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository repository;
  VerifyOtpUseCase(this.repository);

  Future<ApiResult<void>> execute(String email, String token, AuthOtpType type) {
    return repository.verifyOtp(email, token, type);
  }
}
