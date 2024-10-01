import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_sync/core/error/exception/server_exception.dart';
import 'package:task_sync/features/task/data/task_model.dart';

abstract class TaskRemoteDataSource {
  /// Calls the firebase endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<TaskModel>> getAllTask(String uid);

  /// Calls the firebase endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<void> insertTask(TaskModel model, String uid);

  /// Calls the firebase endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<void> updateTask(TaskModel model, String uid);
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final FirebaseFirestore firestore;

  TaskRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<TaskModel>> getAllTask(String uid) async {
    try {
      final tasksSnapshot = await firestore
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .get();

      // Mapping Firestore documents to TaskModel
      List<TaskModel> tasks = tasksSnapshot.docs
          .map((doc) => TaskModel.fromMap(doc.data()))
          .toList();

      return tasks;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> insertTask(TaskModel model, String uid) async {
    try {
      await firestore
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .doc(model.id)
          .set(model.toMap(), SetOptions(merge: true));
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> updateTask(TaskModel model,String uid) async{
    try {
      final updatedModel = model.copyWith(show: 'no');
      await firestore
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .doc(model.id)
          .set(updatedModel.toMap(), SetOptions(merge: true));
    } catch (e) {
      throw ServerException();
    }
  }
}
