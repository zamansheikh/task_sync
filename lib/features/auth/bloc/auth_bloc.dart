import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_sync/features/auth/data/auth_remote_data_source.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:task_sync/features/auth/data/user_model.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRemoteDataSource authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<CheckAuthEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final isLoggedIn = await authRepository.isLoggedIn();
        if (isLoggedIn) {
          final UserModel? user = await authRepository.getCurrentUser();
          if (user != null) {
            emit(AuthenticatedState(user));
          } else {
            emit(UnauthenticatedState());
          }
        } else {
          emit(UnauthenticatedState());
        }
      } catch (e) {
        emit(AuthError('Error checking authentication status.'));
      }
    });

    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepository.loginWithEmailAndPassword(
            event.email, event.password);
        emit(AuthenticatedState(user));
      } catch (e) {
        emit(AuthError('Login failed. Please try again.'));
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.logout();
        emit(UnauthenticatedState());
      } catch (e) {
        emit(AuthError('Logout failed. Please try again.'));
      }
    });
  }
}
