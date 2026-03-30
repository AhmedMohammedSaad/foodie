import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> login(String email, String password);
  Future<AuthModel> signup(String email, String password, String name);
  Future<void> forgotPassword(String email);
  Future<AuthModel?> getCurrentUser();
  Future<void> verifyOtp(String email, String token, AuthOtpType type);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient _supabaseClient;

  AuthRemoteDataSourceImpl(this._supabaseClient);

  @override
  Future<AuthModel> login(String email, String password) async {
    final response = await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
    if (response.user == null) {
      throw Exception('Login failed: User is null');
    }
    return AuthModel(
      id: response.user!.id,
      email: response.user!.email!,
      name: response.user!.userMetadata?['name'] as String?,
    );
  }

  @override
  Future<AuthModel> signup(String email, String password, String name) async {
    final response = await _supabaseClient.auth.signUp(
      email: email,
      password: password,
      data: {'name': name},
    );
    if (response.user == null) {
      throw Exception('Signup failed: User is null');
    }
    return AuthModel(
      id: response.user!.id,
      email: response.user!.email!,
      name: name,
    );
  }

  @override
  Future<void> forgotPassword(String email) async {
    await _supabaseClient.auth.resetPasswordForEmail(email);
  }

  @override
  Future<AuthModel?> getCurrentUser() async {
    final user = _supabaseClient.auth.currentUser;
    if (user != null) {
      return AuthModel(
        id: user.id,
        email: user.email!,
        name: user.userMetadata?['name'] as String?,
      );
    }
    return null;
  }

  @override
  Future<void> verifyOtp(String email, String token, AuthOtpType type) async {
    OtpType supabaseType;
    switch (type) {
      case AuthOtpType.signup:
        supabaseType = OtpType.signup;
        break;
      case AuthOtpType.recovery:
        supabaseType = OtpType.recovery;
        break;
      case AuthOtpType.emailChange:
        supabaseType = OtpType.emailChange;
        break;
      case AuthOtpType.magicLink:
        supabaseType = OtpType.magiclink;
        break;
    }

    await _supabaseClient.auth.verifyOTP(
      email: email,
      token: token,
      type: supabaseType,
    );
  }
}
