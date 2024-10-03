import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_sync/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:task_sync/features/auth/presentation/bloc/auth_event.dart';
import 'package:task_sync/features/auth/presentation/bloc/auth_state.dart';
import 'package:task_sync/features/auth/data/models/user_model.dart';
import 'package:task_sync/features/task/data/models/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_sync/features/task/presentation/bloc/task_bloc.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AuthBloc authBloc;
  final TaskBloc taskBloc;

  HomeCubit({required this.authBloc, required this.taskBloc})
      : super(const HomeState());

  void loadDataAndUser() async {
    authBloc.add(CheckAuthEvent());
    if (authBloc.state is AuthenticatedState) {
      final user = (authBloc.state as AuthenticatedState).user;
      taskBloc.add(LoadTasksEvent(user.uid));
      emit(state.copyWith(user: user));
    }
    if (authBloc.state is UnauthenticatedState) {
      emit(state.copyWith(isLoading: false));
    }
    if (taskBloc.state is TaskLoadedState) {
      final tasks = (taskBloc.state as TaskLoadedState).tasks;
      emit(state.copyWith(tasks: tasks));
    }
  }
}
