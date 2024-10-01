import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_sync/core/errors/failures.dart';
import 'package:task_sync/features/task/data/models/task_model.dart';
import 'package:task_sync/features/task/domain/usecases/get_all_tasks_usecase.dart';
import 'package:task_sync/features/task/domain/usecases/insert_task_usecase.dart';
import 'package:task_sync/features/task/domain/usecases/update_task_usecase.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetAllTasksUseCase getAllTasksUseCase;
  final InsertTaskUseCase insertTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;

  TaskBloc({
    required this.getAllTasksUseCase,
    required this.insertTaskUseCase,
    required this.updateTaskUseCase,
  }) : super(TaskLoadingState()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<InsertTaskEvent>(_onInsertTask);
    on<UpdateTaskEvent>(_onUpdateTask);
  }

  Future<void> _onLoadTasks(
      LoadTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());

    final Either<Failure, List<TaskModel>> result =
        await getAllTasksUseCase(event.uid);

    result.fold(
      (failure) => emit(TaskErrorState('Error loading tasks')),
      (tasks) => emit(TaskLoadedState(tasks)),
    );
  }

  Future<void> _onInsertTask(
      InsertTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());

    final Either<Failure, void> result =
        await insertTaskUseCase(event.task, event.uid);

    result.fold(
      (failure) => emit(TaskErrorState('Error inserting task')),
      (_) => add(LoadTasksEvent(event.uid)), // Reload tasks after inserting
    );
  }

  Future<void> _onUpdateTask(
      UpdateTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());

    final Either<Failure, void> result =
        await updateTaskUseCase(event.task, event.uid);

    result.fold(
      (failure) => emit(TaskErrorState('Error updating task')),
      (_) => add(LoadTasksEvent(event.uid)), // Reload tasks after updating
    );
  }
}
