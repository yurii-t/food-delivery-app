import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:food_delivery_app/data/datasource/firebase_remote_datasource_impl.dart';
import 'package:food_delivery_app/data/datasource/places_datasource_impl.dart';
import 'package:food_delivery_app/presentation/blocs/auth_status/bloc/auth_status_bloc.dart';
import 'package:food_delivery_app/presentation/blocs/autocomplete/bloc/autocomplete_bloc.dart';
import 'package:food_delivery_app/presentation/blocs/booking/bloc/booking_bloc.dart';
import 'package:food_delivery_app/presentation/blocs/bottombar/bloc/bottombar_bloc.dart';
import 'package:food_delivery_app/presentation/blocs/categories/bloc/categories_bloc.dart';
import 'package:food_delivery_app/presentation/blocs/favorites/bloc/favorites_bloc.dart';
import 'package:food_delivery_app/presentation/blocs/location/bloc/location_bloc.dart';
import 'package:food_delivery_app/presentation/blocs/login/bloc/phone_auth_bloc.dart';
import 'package:food_delivery_app/presentation/blocs/menu/bloc/menu_bloc.dart';
import 'package:food_delivery_app/presentation/blocs/order/bloc/order_bloc.dart';
import 'package:food_delivery_app/presentation/blocs/user/bloc/user_bloc.dart';
import 'package:food_delivery_app/routes/app_router.gr.dart';

// ignore: long-method
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait(
    [
      dotenv.load(fileName: '.env'),
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
        BlocProvider(
          create: (context) => LocationBloc(
            firebaseRemoteDataSourceImpl: FirebaseRemoteDataSourceImpl(),
            placesDatasourceImpl: PlacesDatasourceImpl(),
          )..add(const LoadMap()),
        ),
        BlocProvider(
          create: (context) => MenuBloc(
            FirebaseRemoteDataSourceImpl(),
          ),
        ),
        BlocProvider(
          create: (context) => AutocompleteBloc(
            PlacesDatasourceImpl(),
          )..add(const LoadAutocomplete()),
        ),
        BlocProvider(
          create: (context) => OrderBloc(
            FirebaseRemoteDataSourceImpl(),
          )..add(OrderLoad()),
        ),
        BlocProvider(
          create: (context) => BookingBloc(
            FirebaseRemoteDataSourceImpl(),
          )..add(LoadBooking()),
        ),
        BlocProvider(
          create: (context) => FavoritesBloc(
            FirebaseRemoteDataSourceImpl(),
          )..add(LoadFavorites()),
        ),
        BlocProvider(
          create: (context) => CategoriesBloc(
            FirebaseRemoteDataSourceImpl(),
          )..add(LoadCategories()),
        ),
        BlocProvider(
          create: (context) => BottombarBloc()..add(LoadBottomBar()),
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
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white, fontFamily: 'Nunito'),
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
