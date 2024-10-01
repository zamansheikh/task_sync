import 'package:dartz/dartz.dart';
import 'package:task_sync/core/errors/failures.dart';
import 'package:task_sync/features/task/data/models/task_model.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<TaskModel>>> getAllTasks(String uid);
  Future<Either<Failure, void>> insertTask(TaskModel task, String uid);
  Future<Either<Failure, void>> updateTask(TaskModel task, String uid);
}
