import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:task_sync/core/platform/network_info.dart';
import 'package:task_sync/features/auth/bloc/auth_bloc.dart';
import 'package:task_sync/features/auth/data/auth_remote_data_source.dart';
import 'package:task_sync/features/task/bloc/task_bloc.dart';
import 'package:task_sync/features/task/cubit/home_cubit.dart';
import 'package:task_sync/features/task/data/task_remote_data_source.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubits
  sl.registerFactory(() => HomeCubit(authBloc: sl(), taskBloc: sl()));
  // sl.registerLazySingleton(() => MyUserCubit());
  // sl.registerLazySingleton(() => PostIssueCubit());

  // Bloc
  sl.registerFactory(() => AuthBloc(sl()));
  sl.registerFactory(() => TaskBloc(
        dbHelper: sl(),
        networkInfo: sl(),
        firebaseDatabase: sl(),
      ));

  //Network Info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //! Student Issues
  // Use cases
  // sl.registerLazySingleton(() => GetStudentIssues(sl()));
  // sl.registerLazySingleton(() => PostStudentIssue(sl()));
  // sl.registerLazySingleton(() => ResolveStudentIssue(sl()));

  // Repository
  // sl.registerLazySingleton<StudentIssueRepository>( () => StudentIssueRepositoryImpl());

  //! External
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());

  // External
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseDatabase>(() => FirebaseDatabase.instance);
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: sl(), googleSignIn: sl()),
  );
  sl.registerLazySingleton<TaskRemoteDataSource>(
    () => TaskRemoteDataSourceImpl(
      firestore: sl(),
    ),
  );
}
