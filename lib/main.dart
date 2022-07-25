import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/data/datasource/firebase_remote_datasource_impl.dart';
import 'package:food_delivery_app/presentation/blocs/auth_status/bloc/auth_status_bloc.dart';
import 'package:food_delivery_app/presentation/blocs/login/bloc/phone_auth_bloc.dart';
import 'package:food_delivery_app/presentation/blocs/user/bloc/user_bloc.dart';
import 'package:food_delivery_app/routes/app_router.gr.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait(
    [
      //di.init(),
      Firebase.initializeApp(),
    ],
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthStatusBloc(FirebaseRemoteDataSourceImpl())
            ..add(AuthStatusStarted()),
        ),
        BlocProvider(
          create: (context) => PhoneAuthBloc(
            firebaseRemoteDataSourceImpl: FirebaseRemoteDataSourceImpl(),
          ),
        ),
        BlocProvider(
          create: (context) => UserBloc(
            FirebaseRemoteDataSourceImpl(),
          )..add(LoadUserInfo()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

//ignore: prefer-match-file-name
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      routeInformationParser: _appRouter.defaultRouteParser(),
      routerDelegate: _appRouter.delegate(),
      builder: (context, child) {
        return BlocListener<AuthStatusBloc, AuthStatusState>(
          listener: (context, state) {
            if (state is Authenticated) {
              state.isRegistration == false
                  ? _appRouter.replace(HomeRoute(userId: state.uid))
                  : _appRouter.replace(InformationRoute());
            } else {
              _appRouter.replace(const AuthRoute());
            }
          },
          child: child,
        );
      },
    );
  }
}
