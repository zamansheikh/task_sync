import 'package:dartz/dartz.dart';
import 'package:task_sync/core/errors/exceptions.dart';
import 'package:task_sync/core/errors/failures.dart';
import 'package:task_sync/features/task/data/datasources/task_remote_data_source.dart';
import 'package:task_sync/features/task/data/models/task_model.dart';
import 'package:task_sync/features/task/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;

  TaskRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<TaskModel>>> getAllTasks(String uid) async {
    try {
      final tasks = await  remoteDataSource.getAllTask(uid);
      return Right(tasks);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> insertTask(TaskModel task, String uid) async {
    try {
      await remoteDataSource.insertTask(task, uid);
      return Right(null);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateTask(TaskModel task, String uid) async {
    try {
      await remoteDataSource.updateTask(task, uid);
      return Right(null);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
