import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/data/datasource/firebase_remote_datasource_impl.dart';
import 'package:food_delivery_app/data/models/current_user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FirebaseRemoteDataSourceImpl firebaseRemoteDataSourceImpl;
  UserBloc(this.firebaseRemoteDataSourceImpl) : super(UserInitial()) {
    on<CreateCurrentUser>((event, emit) async {
      try {
        await firebaseRemoteDataSourceImpl.createCurrentUser(CurrentUser(
            userId: '', name: event.name, phoneNumber: '', email: event.email));
      } on SocketException catch (e) {
        emit(UserError(e.toString()));
      }
    });
    on<LoadUserInfo>((event, emit) async {
      try {
        // final userInfo = await getCurrentUserInfoUseCase.call(NoParams());
        final userInfo =
            await firebaseRemoteDataSourceImpl.getCurrentUserInfo();
        emit(UserLoaded(userInfo));
      } on SocketException catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
