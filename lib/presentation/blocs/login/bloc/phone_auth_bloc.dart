import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery_app/data/datasource/firebase_remote_datasource_impl.dart';
import 'package:food_delivery_app/data/models/current_user.dart';

part 'phone_auth_event.dart';
part 'phone_auth_state.dart';

class PhoneAuthBloc extends Bloc<PhoneAuthEvent, PhoneAuthState> {
  final FirebaseRemoteDataSourceImpl firebaseRemoteDataSourceImpl;
  PhoneAuthBloc({required this.firebaseRemoteDataSourceImpl})
      : super(PhoneAuthInitial()) {
    on<SendOtpToPhoneEvent>(_onSendOtp);

    on<VerifySentOtpEvent>(_onVerifyOtp);

    on<OnPhoneOtpSent>((event, emit) =>
        emit(PhoneAuthCodeSentSuccess(verificationId: event.verificationId)));

    on<OnPhoneAuthErrorEvent>(
      (event, emit) => emit(PhoneAuthError(error: event.error)),
    );

    on<OnPhoneAuthVerificationCompleteEvent>(_loginWithCredential);

    on<OnPhoneAuthGoogleSignIn>((event, emit) async {
      emit(PhoneAuthLoading());
      try {
        final credential =
            await firebaseRemoteDataSourceImpl.signInWithGoogle();
        await firebaseRemoteDataSourceImpl
            .signInWithCredential(credential)
            .then((user) {
          if (user.user != null) {
            firebaseRemoteDataSourceImpl.createCurrentUser(
              CurrentUser(
                userId: '',
                name: user.user?.displayName ?? '',
                phoneNumber: user.user?.phoneNumber ?? '',
                email: user.user?.email ?? '',
              ),
            );
            emit(PhoneAuthVerified(user.user!.uid));
          }
        });
      } on FirebaseAuthException catch (e) {
        emit(PhoneAuthError(error: e.code));
      } on Exception catch (e) {
        emit(PhoneAuthError(error: e.toString()));
      }
    });
  }

  Future<void> _onSendOtp(
    SendOtpToPhoneEvent event,
    Emitter<PhoneAuthState> emit,
  ) async {
    emit(PhoneAuthLoading());
    try {
      final phoneNumberExists = await firebaseRemoteDataSourceImpl
          .phoneNumberExistsCheck(event.phoneNumber);
      if (phoneNumberExists == false || event.isRegistration == false) {
        await firebaseRemoteDataSourceImpl.verifyPhone(
          phoneNumber: event.phoneNumber,
          verificationCompleted: (credential) async {
            add(OnPhoneAuthVerificationCompleteEvent(credential: credential));
          },
          verificationFailed: (e) {
            add(OnPhoneAuthErrorEvent(error: e.code));
          },
          codeSent: (verificationId, resendToken) {
            add(OnPhoneOtpSent(
              verificationId: verificationId,
              token: resendToken,
            ));
          },
          codeAutoRetrievalTimeout: (verificationId) {
            print(verificationId);
          },
        );
      } else {
        emit(PhoneAuthPhoneNumberExist());
      }
    } on Exception catch (e) {
      emit(PhoneAuthError(error: e.toString()));
    }
  }

  Future<void> _onVerifyOtp(
    VerifySentOtpEvent event,
    Emitter<PhoneAuthState> emit,
  ) async {
    try {
      emit(PhoneAuthLoading());

      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: event.verificationId,
        smsCode: event.otpCode,
      );
      add(OnPhoneAuthVerificationCompleteEvent(credential: credential));
    } on Exception catch (e) {
      emit(PhoneAuthError(error: e.toString()));
    }
  }

  Future<void> _loginWithCredential(
    OnPhoneAuthVerificationCompleteEvent event,
    Emitter<PhoneAuthState> emit,
  ) async {
    try {
      await firebaseRemoteDataSourceImpl
          .signInWithCredential(event.credential)
          .then((user) {
        if (user.user != null) {
          firebaseRemoteDataSourceImpl.createCurrentUser(
            CurrentUser(
              userId: '',
              name: '',
              phoneNumber: '',
              email: '',
            ),
          );
          emit(PhoneAuthVerified(user.user!.uid));
        }
      });
    } on FirebaseAuthException catch (e) {
      emit(PhoneAuthError(error: e.code));
    } on Exception catch (e) {
      emit(PhoneAuthError(error: e.toString()));
    }
  }
}
