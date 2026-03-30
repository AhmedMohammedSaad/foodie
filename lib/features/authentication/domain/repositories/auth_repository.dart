import '../../../../core/models/api_result.dart';
import '../entities/user_entity.dart';

enum AuthOtpType { signup, recovery, emailChange, magicLink }

abstract class AuthRepository {
  Future<ApiResult<UserEntity>> login(String email, String password);
  Future<ApiResult<UserEntity>> signup(String email, String password, String name);
  Future<ApiResult<void>> forgotPassword(String email);
  Future<ApiResult<void>> verifyOtp(String email, String token, AuthOtpType type);
  Future<ApiResult<UserEntity?>> getCurrentUser();
}
