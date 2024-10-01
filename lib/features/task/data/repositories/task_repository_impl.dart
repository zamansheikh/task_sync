import 'package:dartz/dartz.dart';
import 'package:task_sync/core/errors/failures.dart';
import 'package:task_sync/features/task/data/datasources/task_remote_data_source.dart';
import 'package:task_sync/features/task/data/models/task_model.dart';
import 'package:task_sync/features/task/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;

  TaskRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<TaskModel>>> getTasks() async {
    try {
      final tasks = await remoteDataSource.getAllTask("123UID");
      return Right(tasks);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addTask(TaskModel task) async {
    try {
      await remoteDataSource.insertTask(task, "123UID");
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateTask(TaskModel task) async {
    try {
      await remoteDataSource.updateTask(task, "123UID");
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
