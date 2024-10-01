import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_sync/core/platform/network_info.dart';
import 'package:task_sync/features/auth/bloc/auth_bloc.dart';
import 'package:task_sync/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:task_sync/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:task_sync/features/auth/domain/repositories/auth_repository.dart';
import 'package:task_sync/features/auth/domain/usecases/check_auth_status_use_case.dart';
import 'package:task_sync/features/auth/domain/usecases/login_use_case.dart';
import 'package:task_sync/features/auth/domain/usecases/logout_use_case.dart';
import 'package:task_sync/features/task/data/repositories/task_repository_impl.dart';
import 'package:task_sync/features/task/domain/repositories/task_repository.dart';
import 'package:task_sync/features/task/domain/usecases/get_all_task_usecase.dart';
import 'package:task_sync/features/task/domain/usecases/insert_task_usecase.dart';
import 'package:task_sync/features/task/domain/usecases/update_task_usecase.dart';
import 'package:task_sync/features/task/presentation/bloc/task_bloc.dart';
import 'package:task_sync/features/task/presentation/cubit/home_cubit.dart';
import 'package:task_sync/features/task/data/datasources/task_remote_data_source.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External dependencies
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());

  // Firebase and Google SignIn instances
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseDatabase>(() => FirebaseDatabase.instance);
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());

  // Network Info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl(),
      googleSignIn: sl(),
    ),
  );
  sl.registerLazySingleton<TaskRemoteDataSource>(
    () => TaskRemoteDataSourceImpl(
      firestore: sl(),
    ),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<TaskRepository>(
      () => TaskRepositoryImpl(remoteDataSource: sl()));

  // Use cases
  sl.registerLazySingleton(() => CheckAuthStatusUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetAllTasksUseCase(sl()));
  sl.registerLazySingleton(() => InsertTaskUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTaskUseCase(sl()));

  // Bloc and Cubit registrations
  sl.registerFactory(() => HomeCubit(
        authBloc: sl(),
        taskBloc: sl(),
      ));
  sl.registerFactory(() => AuthBloc(
        checkAuthStatusUseCase: sl(),
        loginUseCase: sl(),
        logoutUseCase: sl(),
      ));
  sl.registerFactory(() => TaskBloc(
        getAllTasksUseCase: sl(),
        insertTaskUseCase: sl(),
        updateTaskUseCase: sl(),
      ));
}
