import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_sync/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:task_sync/features/auth/presentation/bloc/auth_state.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AuthBloc authBloc;

  SplashCubit(this.authBloc) : super(SplashLoading());

  void checkUser() async {
    emit(SplashLoading());
    // Listen for changes in the AuthBloc's state
    while (authBloc.state is AuthInitial || authBloc.state is AuthLoading) {
      await Future.delayed(const Duration(milliseconds: 200), () {
      });
    }
    final authState = authBloc.state;
    if (authState is AuthenticatedState) {
      emit(SplashLoggedIn(authState.user.uid));
    } else if (authState is UnauthenticatedState) {
      emit(SplashLoggedOut());
    } else if (authState is AuthError) {
      emit(SplashError());
    } else {
      // Keep showing loading if AuthBloc is still working (AuthLoading state)
      emit(SplashLoading());
    }
  }
}
