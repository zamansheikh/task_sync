import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:task_sync/features/task/data/task_model.dart';
import 'package:task_sync/features/task/data/task_remote_data_source.dart';
import 'package:task_sync/injection_container.dart';

class DbHelper {
  static const String taskBoxName = 'tasksBox';
  static const String pendingUploadsBoxName = 'pendingUploadsBox';
  static const String pendingDeletesBoxName = 'pendingDeletesBox';

  Future<void> initializeHive() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    // Registering adapter for TaskModel
    Hive.registerAdapter(TaskModelAdapter());

    // Opening boxes
    await Hive.openBox<TaskModel>(taskBoxName);
    await Hive.openBox<TaskModel>(pendingUploadsBoxName);
    await Hive.openBox<TaskModel>(pendingDeletesBoxName);
  }

  Future<TaskModel> insert(TaskModel model, String uid) async {
    final Connectivity connectivity = Connectivity();
    var connection = await connectivity.checkConnectivity();

    if (connection.contains(ConnectivityResult.wifi) ||
        connection.contains(ConnectivityResult.mobile)) {
      await Hive.box<TaskModel>(taskBoxName).put(model.id, model);
      sl<TaskRemoteDataSource>().insertTask(model, uid);
      // FirebaseService.insertData(model);
    } else {
      await Hive.box<TaskModel>(pendingUploadsBoxName).put(model.id, model);
    }

    return model;
  }

  Future<void> removeFromList(TaskModel model, String uid) async {
    final Connectivity connectivity = Connectivity();
    var connection = await connectivity.checkConnectivity();

    final updatedModel = model.copyWith(show: 'no');

    await Hive.box<TaskModel>(taskBoxName).put(model.id, updatedModel);

    if (connection.contains(ConnectivityResult.wifi) ||
        connection.contains(ConnectivityResult.mobile)) {
      // FirebaseService.update(model.id, 'show', 'no');
      sl<TaskRemoteDataSource>().updateTask(model, uid);
    } else {
      await Hive.box<TaskModel>(pendingDeletesBoxName).put(model.id, model);
    }
  }

  Future<void> update(TaskModel model) async {
    await Hive.box<TaskModel>(taskBoxName).put(model.id, model);
  }

  Future<int> delete(String id, String boxName) async {
    await Hive.box<TaskModel>(boxName).delete(id);
    return 1;
  }

  Future<List<TaskModel>> getData() async {
    final box = Hive.box<TaskModel>(taskBoxName);
    return box.values.toList();
  }

  Future<List<TaskModel>> getPendingUploads() async {
    final box = Hive.box<TaskModel>(pendingUploadsBoxName);
    return box.values.toList();
  }

  Future<List<TaskModel>> getPendingDeletes() async {
    final box = Hive.box<TaskModel>(pendingDeletesBoxName);
    return box.values.toList();
  }

  Future<bool> isRowExists(String id, String boxName) async {
    final box = Hive.box<TaskModel>(boxName);
    return box.containsKey(id);
  }
}
