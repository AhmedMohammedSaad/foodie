import '../../../../core/models/api_result.dart';
import '../../../../core/models/failure.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<UserEntity>> login(String email, String password) async {
    try {
      final user = await _remoteDataSource.login(email, password);
      return ApiResult.success(user);
    } catch (e) {
      return ApiResult.failure(Failure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<UserEntity>> signup(
      String email, String password, String name) async {
    try {
      final user = await _remoteDataSource.signup(email, password, name);
      return ApiResult.success(user);
    } catch (e) {
      return ApiResult.failure(Failure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<void>> forgotPassword(String email) async {
    try {
      await _remoteDataSource.forgotPassword(email);
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(Failure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<void>> verifyOtp(String email, String token, AuthOtpType type) async {
    try {
      await _remoteDataSource.verifyOtp(email, token, type);
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(Failure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<UserEntity?>> getCurrentUser() async {
    try {
      final user = await _remoteDataSource.getCurrentUser();
      return ApiResult.success(user);
    } catch (e) {
      return ApiResult.failure(Failure(message: e.toString()));
    }
  }
}
