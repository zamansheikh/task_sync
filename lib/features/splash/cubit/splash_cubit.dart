import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_sync/features/auth/domain/usecases/check_auth_status_use_case.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final CheckAuthStatusUseCase checkAuthUseCase; // Inject the use case

  SplashCubit(this.checkAuthUseCase) : super(SplashLoading());

  Future<void> checkUser() async {
    emit(SplashLoading());
    final result = await checkAuthUseCase();
    result.fold(
      (failure) {
        emit(SplashError());
      },
      (user) {
        if (user != null) {
          emit(SplashLoggedIn(user.uid));
        } else {
          emit(SplashLoggedOut());
        }
      },
    );
  }
}
