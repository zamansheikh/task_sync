import 'package:dartz/dartz.dart';
import 'package:task_sync/core/errors/failures.dart';
import 'package:task_sync/features/task/data/models/task_model.dart';
import 'package:task_sync/features/task/domain/repositories/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository repository;

  GetTasksUseCase(this.repository);

  Future<Either<Failure, List<TaskModel>>> call() async {
    return await repository.getTasks();
  }
}
