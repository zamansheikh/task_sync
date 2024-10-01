import 'package:dartz/dartz.dart';
import 'package:task_sync/core/errors/failures.dart';
import 'package:task_sync/features/task/data/models/task_model.dart';
import 'package:task_sync/features/task/domain/repositories/task_repository.dart';

class UpdateTaskUseCase {
  final TaskRepository repository;

  UpdateTaskUseCase(this.repository);

  Future<Either<Failure, void>> call(TaskModel task) async {
    return await repository.updateTask(task);
  }
}
