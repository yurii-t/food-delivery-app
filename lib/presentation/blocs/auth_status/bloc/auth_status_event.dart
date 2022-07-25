part of 'auth_status_bloc.dart';

abstract class AuthStatusEvent extends Equatable {
  const AuthStatusEvent();

  @override
  List<Object> get props => [];
}

class AuthStatusStarted extends AuthStatusEvent {}

class AuthStatusLogedIn extends AuthStatusEvent {
  final bool isRegistration;

  const AuthStatusLogedIn({required this.isRegistration});
  @override
  List<Object> get props => [isRegistration];
}

class AuthStatusLogedOut extends AuthStatusEvent {}
