part of 'task_bloc.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

// State when the tasks are loading
class TaskLoadingState extends TaskState {}

// State when tasks are successfully loaded
class TaskLoadedState extends TaskState {
  final List<TaskModel> tasks;

  const TaskLoadedState(this.tasks);

  @override
  List<Object> get props => [tasks];
}

// State when tasks are syncing to Firebase
class TaskSyncingState extends TaskState {}

// State when tasks are removed
class TaskRemovedState extends TaskState {
  final TaskModel task;

  const TaskRemovedState(this.task);

  @override
  List<Object> get props => [task];
}

// State when the app is offline and tasks are pending sync
class TaskOfflineState extends TaskState {
  final List<TaskModel> pendingUploads;
  final List<TaskModel> pendingDeletes;

  const TaskOfflineState(this.pendingUploads, this.pendingDeletes);

  @override
  List<Object> get props => [pendingUploads, pendingDeletes];
}

// Error state
class TaskErrorState extends TaskState {
  final String message;

  const TaskErrorState(this.message);

  @override
  List<Object> get props => [message];
}
