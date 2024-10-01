import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_sync/features/auth/bloc/auth_bloc.dart';
import 'package:task_sync/features/auth/bloc/auth_state.dart';
import 'package:task_sync/features/auth/data/models/user_model.dart';
import 'package:task_sync/features/task/data/models/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_sync/features/task/bloc/task_bloc.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AuthBloc authBloc;
  final TaskBloc taskBloc;

  HomeCubit({required this.authBloc, required this.taskBloc})
      : super(const HomeState()) {
    // Listen for changes in AuthBloc and TaskBloc and react accordingly.
    authBloc.stream.listen((authState) {
      if (authState is AuthenticatedState) {
        emit(state.copyWith(user: authState.user));
      }
    });

    taskBloc.stream.listen((taskState) {
      if (taskState is TaskLoadedState) {
        emit(state.copyWith(tasks: taskState.tasks));
      } else if (taskState is TaskErrorState) {
        emit(state.copyWith(errorMessage: taskState.message));
      }
    });
  }

  void loadInitialData() {
    emit(state.copyWith(isLoading: true));
    // Optionally, initiate loading data here if necessary.
  }

  void refreshTasks() {
    taskBloc.add(LoadTasksEvent());
  }
}
