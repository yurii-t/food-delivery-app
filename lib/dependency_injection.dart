// import 'package:food_delivery_app/data/datasource/firebase_remote_datasource.dart';
// import 'package:food_delivery_app/data/datasource/firebase_remote_datasource_impl.dart';
// import 'package:food_delivery_app/presentation/blocs/auth_status/bloc/auth_status_bloc.dart';
// import 'package:food_delivery_app/presentation/blocs/login/bloc/phone_auth_bloc.dart';
// import 'package:get_it/get_it.dart';

// final GetIt sl = GetIt.instance;
// // ignore: long-method
// Future<void> init() async {
//   //Bloc
//   sl
//     ..registerLazySingleton<AuthStatusBloc>(() => AuthStatusBloc(
//           sl.call(),
//         )..add(AuthStatusStarted()))
//     ..registerLazySingleton<PhoneAuthBloc>(() => PhoneAuthBloc(
//           firebaseRemoteDataSourceImpl: sl.call(),
//         ))
//     //DataSource
//     ..registerLazySingleton<FirebaseRemoteDataSource>(
//       FirebaseRemoteDataSourceImpl.new,
//     );

//   //External
// }
