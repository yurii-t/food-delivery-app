import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/data/datasource/firebase_remote_datasource.dart';
import 'package:food_delivery_app/data/datasource/firebase_remote_datasource_impl.dart';

part 'auth_status_event.dart';
part 'auth_status_state.dart';

class AuthStatusBloc extends Bloc<AuthStatusEvent, AuthStatusState> {
  final FirebaseRemoteDataSourceImpl firebaseRemoteDataSourceImpl;

  AuthStatusBloc(this.firebaseRemoteDataSourceImpl)
      : super(AuthStatusInitial()) {
    on<AuthStatusStarted>(onAuthStatusStarted);
    on<AuthStatusLogedIn>(onAuthStatusLogedIn);
    on<AuthStatusLogedOut>(onAuthStatusLogedOut);
  }

  Future<void> onAuthStatusStarted(
    AuthStatusStarted event,
    Emitter<AuthStatusState> emit,
  ) async {
    try {
      // final bool isSignIn = await isSignInUseCase.call(NoParams());
      final bool isSignIn = await firebaseRemoteDataSourceImpl.isSignIn();

      if (isSignIn) {
        final String uid = await firebaseRemoteDataSourceImpl
            .getCurrentUserUid(); //await getCurrentUserUidUseCase.call(NoParams());
        emit(Authenticated(uid: uid));
      } else
        emit(UnAuthenticated());
    } on Exception catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> onAuthStatusLogedIn(
    AuthStatusLogedIn event,
    Emitter<AuthStatusState> emit,
  ) async {
    try {
      final String uid = await firebaseRemoteDataSourceImpl
          .getCurrentUserUid(); //await getCurrentUserUidUseCase.call(NoParams());
      emit(Authenticated(uid: uid));
    } on Exception catch (_) {}
  }

  Future<void> onAuthStatusLogedOut(
    AuthStatusLogedOut event,
    Emitter<AuthStatusState> emit,
  ) async {
    try {
      // await signOutUseCase.call(NoParams());
      await firebaseRemoteDataSourceImpl.signOut();
      emit(UnAuthenticated());
    } on Exception catch (_) {}
  }
}
