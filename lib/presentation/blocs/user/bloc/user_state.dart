part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserError extends UserState {
  final String error;

  const UserError(this.error);

  @override
  List<Object> get props => [error];
}

class UserLoaded extends UserState {
  final CurrentUser usersInfo;

  const UserLoaded(this.usersInfo);

  @override
  List<Object> get props => [usersInfo];
}
