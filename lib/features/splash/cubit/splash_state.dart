part of 'splash_cubit.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

final class SplashError extends SplashState {}

final class SplashLoggedIn extends SplashState {
  final String user;

  const SplashLoggedIn(this.user);

  @override
  List<Object> get props => [user];
}

final class SplashLoggedOut extends SplashState {}

final class SplashLoading extends SplashState {}
