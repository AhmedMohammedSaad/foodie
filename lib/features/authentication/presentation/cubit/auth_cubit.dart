import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import '../../domain/usecases/forgot_password_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import '../../domain/usecases/check_session_usecase.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final SignupUseCase signupUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final CheckSessionUseCase checkSessionUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.signupUseCase,
    required this.forgotPasswordUseCase,
    required this.verifyOtpUseCase,
    required this.checkSessionUseCase,
  }) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final result = await loginUseCase.execute(email, password);
    result.fold(
      (user) => emit(AuthSuccess(user)),
      (failure) => emit(AuthError(failure.message)),
    );
  }

  Future<void> signup(String email, String password, String name) async {
    emit(AuthLoading());
    final result = await signupUseCase.execute(email, password, name);
    result.fold(
      (user) => emit(AuthSuccess(user)),
      (failure) => emit(AuthError(failure.message)),
    );
  }

  Future<void> checkSession() async {
    emit(AuthLoading());
    final result = await checkSessionUseCase.execute();
    result.fold(
      (user) {
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(AuthUnauthenticated());
        }
      },
      (failure) => emit(AuthError(failure.message)),
    );
  }

  Future<void> forgotPassword(String email) async {
    emit(AuthLoading());
    final result = await forgotPasswordUseCase.execute(email);
    result.fold(
      (_) => emit(ForgotPasswordEmailSent()),
      (failure) => emit(AuthError(failure.message)),
    );
  }

  Future<void> verifyOtp(String email, String token, AuthOtpType type) async {
    emit(AuthLoading());
    final result = await verifyOtpUseCase.execute(email, token, type);
    result.fold(
      (_) => emit(OtpVerified()),
      (failure) => emit(AuthError(failure.message)),
    );
  }
}
