part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTasksEvent extends TaskEvent {
  final String uid;

  LoadTasksEvent(this.uid);

  @override
  List<Object?> get props => [uid];
}

class InsertTaskEvent extends TaskEvent {
  final TaskModel task;
  final String uid;

  InsertTaskEvent(this.task, this.uid);

  @override
  List<Object?> get props => [task, uid];
}

class UpdateTaskEvent extends TaskEvent {
  final TaskModel task;
  final String uid;

  UpdateTaskEvent(this.task, this.uid);

  @override
  List<Object?> get props => [task, uid];
}
