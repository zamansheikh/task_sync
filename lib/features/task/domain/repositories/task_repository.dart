import 'package:dartz/dartz.dart';
import 'package:task_sync/core/errors/failures.dart';
import 'package:task_sync/features/task/data/models/task_model.dart';
abstract class TaskRepository {
  Future<Either<Failure, List<TaskModel>>> getTasks();
  Future<Either<Failure, void>> addTask(TaskModel task);
  Future<Either<Failure, void>> updateTask(TaskModel task);
}
