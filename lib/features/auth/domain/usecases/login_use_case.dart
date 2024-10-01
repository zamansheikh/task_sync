import 'package:dartz/dartz.dart';
import 'package:task_sync/core/errors/failures.dart';
import 'package:task_sync/features/auth/data/models/user_model.dart';
import 'package:task_sync/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, UserModel>> call(String email, String password) async {
    return await repository.loginWithEmailAndPassword(email, password);
  }
}
