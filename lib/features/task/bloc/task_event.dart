part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

// Event to load tasks from local storage
class LoadTasksEvent extends TaskEvent {}

// Event for syncing tasks when connectivity is restored
class SyncTasksEvent extends TaskEvent {}

// Event for removing a task from the list
class RemoveTaskEvent extends TaskEvent {
  final TaskModel task;
  final String uid;

  const RemoveTaskEvent(this.task, this.uid);

  @override
  List<Object> get props => [task,uid];
}

// Event to listen to task changes from Firebase
class ListenToFirebaseTasksEvent extends TaskEvent {}
