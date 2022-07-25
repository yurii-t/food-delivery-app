import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery_app/data/models/current_user.dart';

abstract class FirebaseRemoteDataSource {
  Future<void> verifyPhone({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  });

  Future<UserCredential> signInWithCredential(AuthCredential credential);

  Future<void> createCurrentUser(CurrentUser user);

  Future<String> getCurrentUserUid();

  Future<bool> isSignIn();

  Future<void> signOut();

  Future<CurrentUser> getCurrentUserInfo();
  Future<bool> phoneNumberExistsCheck(String phoneNumber);
  Future<OAuthCredential> signInWithGoogle();
}
