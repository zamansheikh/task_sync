import 'package:dartz/dartz.dart';
import 'package:task_sync/core/errors/failures.dart';
import 'package:task_sync/features/auth/data/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> loginWithEmailAndPassword(String email, String password);
  Future<Either<Failure, UserModel?>> getCurrentUser();
  Future<Either<Failure, void>> logout();
}
