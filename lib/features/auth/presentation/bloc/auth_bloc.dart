import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:task_sync/core/errors/failures.dart';
import 'package:task_sync/features/auth/domain/usecases/check_auth_status_use_case.dart';
import 'package:task_sync/features/auth/domain/usecases/login_use_case.dart';
import 'package:task_sync/features/auth/domain/usecases/logout_use_case.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:task_sync/features/auth/data/models/user_model.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CheckAuthStatusUseCase checkAuthStatusUseCase;
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;

  AuthBloc({
    required this.checkAuthStatusUseCase,
    required this.loginUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial()) {
    // Check if user is authenticated
    on<CheckAuthEvent>((event, emit) async {
      emit(AuthLoading());

      final Either<Failure, UserModel?> authStatus =
          await checkAuthStatusUseCase();

      authStatus.fold(
        (failure) => emit(AuthError('Error checking authentication status.')),
        (user) {
          print('Checking auth status...$user');
          if (user != null) {
            emit(AuthenticatedState(user));
          } else {
            emit(UnauthenticatedState());
          }
        },
      );
    });

    // Handle user signup
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      final Either<Failure, UserModel> signupResult =
          await loginUseCase(event.email, event.password);

      signupResult.fold(
        (failure) => emit(AuthError('Signup failed. Please try again.')),
        (user) => emit(AuthenticatedState(user)),
      );
    });

    // Handle user login
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      final Either<Failure, UserModel> loginResult =
          await loginUseCase(event.email, event.password);

      loginResult.fold(
        (failure) => emit(AuthError('Login failed. Please try again.')),
        (user) => emit(AuthenticatedState(user)),
      );
    });

    // Handle user logout
    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());
      final Either<Failure, void> logoutResult = await logoutUseCase();

      logoutResult.fold(
        (failure) => emit(AuthError('Logout failed. Please try again.')),
        (_) => emit(UnauthenticatedState()),
      );
    });
  }
}
