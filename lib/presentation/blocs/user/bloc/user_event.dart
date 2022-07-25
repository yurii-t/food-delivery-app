part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class CreateCurrentUser extends UserEvent {
  final String name;

  final String email;

  const CreateCurrentUser(
    this.name,
    this.email,
  );

  @override
  List<Object> get props => [
        name,
        email,
      ];
}

class LoadUserInfo extends UserEvent {}
