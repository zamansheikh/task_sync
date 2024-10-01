part of 'home_cubit.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final UserModel? user;
  final List<TaskModel> tasks;
  final String errorMessage;

  const HomeState({
    this.isLoading = false,
    this.user,
    this.tasks = const [],
    this.errorMessage = '',
  });

  @override
  List<Object?> get props => [isLoading, user, tasks, errorMessage];

  HomeState copyWith({
    bool? isLoading,
    UserModel? user,
    List<TaskModel>? tasks,
    String? errorMessage,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      tasks: tasks ?? this.tasks,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}