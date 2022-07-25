part of 'phone_auth_bloc.dart';

abstract class PhoneAuthState extends Equatable {
  const PhoneAuthState();

  @override
  List<Object> get props => [];
}

class PhoneAuthInitial extends PhoneAuthState {}

class PhoneAuthLoading extends PhoneAuthState {}

class PhoneAuthError extends PhoneAuthState {
  final String error;

  const PhoneAuthError({required this.error});

  @override
  List<Object> get props => [error];
}

class PhoneAuthVerified extends PhoneAuthState {
  final String uid;

  const PhoneAuthVerified(this.uid);
  @override
  List<Object> get props => [uid];
}

class PhoneAuthCodeSentSuccess extends PhoneAuthState {
  final String verificationId;
  // final int time;
  const PhoneAuthCodeSentSuccess({
    required this.verificationId,
    // required this.time,
  });
  @override
  List<Object> get props => [
        // verificationId
      ];
}

class PhoneAuthPhoneNumberExist extends PhoneAuthState {}
