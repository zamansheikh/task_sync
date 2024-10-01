import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:task_sync/core/platform/network_info.dart';
import 'package:task_sync/features/task/data/datasources/db_helper.dart';
import 'package:task_sync/features/task/data/models/task_model.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final DbHelper dbHelper;
  final NetworkInfo networkInfo;
  final FirebaseDatabase firebaseDatabase;

  TaskBloc(
      {required this.dbHelper,
      required this.networkInfo,
      required this.firebaseDatabase})
      : super(TaskLoadingState()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<SyncTasksEvent>(_onSyncTasks);
    on<RemoveTaskEvent>(_onRemoveTask);
    on<ListenToFirebaseTasksEvent>(_onListenToFirebaseTasks);

    // Listening for connectivity changes
    Connectivity().onConnectivityChanged.listen(
      (result) {
        if (result.contains(ConnectivityResult.wifi) ||
            result.contains(ConnectivityResult.mobile)) {
          add(SyncTasksEvent());
        }
      },
    );
  }

  Future<void> _onLoadTasks(
      LoadTasksEvent event, Emitter<TaskState> emit) async {
    try {
      final tasks = await dbHelper.getData();
      final pendingUploads = await dbHelper.getPendingUploads();
      final pendingDeletes = await dbHelper.getPendingDeletes();

      if (await networkInfo.isConnected) {
        emit(TaskLoadedState(tasks));
      } else {
        emit(TaskOfflineState(pendingUploads, pendingDeletes));
      }
    } catch (e) {
      emit(TaskErrorState('Error loading tasks: $e'));
    }
  }

  Future<void> _onSyncTasks(
      SyncTasksEvent event, Emitter<TaskState> emit) async {
    try {
      final pendingUploads = await dbHelper.getPendingUploads();
      final pendingDeletes = await dbHelper.getPendingDeletes();

      for (var task in pendingUploads) {
        // Sync to Firebase
        await firebaseDatabase.ref('Tasks').child(task.id).set(task.toMap());
        await dbHelper.delete(task.id, 'PendingUploads');
      }

      for (var task in pendingDeletes) {
        await firebaseDatabase
            .ref('Tasks')
            .child(task.id)
            .update({'show': 'no'});
        await dbHelper.delete(task.id, 'PendingDeletes');
      }

      final tasks = await dbHelper.getData();
      emit(TaskLoadedState(tasks));
    } catch (e) {
      emit(TaskErrorState('Error syncing tasks: $e'));
    }
  }

  Future<void> _onRemoveTask(
      RemoveTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await dbHelper.removeFromList(event.task, event.uid);
      final tasks = await dbHelper.getData();
      emit(TaskRemovedState(event.task));
      emit(TaskLoadedState(tasks));
    } catch (e) {
      emit(TaskErrorState('Error removing task: $e'));
    }
  }

  Future<void> _onListenToFirebaseTasks(
      ListenToFirebaseTasksEvent event, Emitter<TaskState> emit) async {
    final userUid = "Your Firebase User UID";
    firebaseDatabase
        .ref('Tasks')
        .child(userUid)
        .onValue
        .listen((snapshot) async {
      // Handle snapshot data
      final tasks = await dbHelper.getData();
      emit(TaskLoadedState(tasks));
    });
  }
}
