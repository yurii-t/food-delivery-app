import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery_app/data/datasource/firebase_remote_datasource.dart';
import 'package:food_delivery_app/data/models/current_user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<String> getCurrentUserUid() async => await auth.currentUser?.uid ?? '';
  @override
  Future<bool> isSignIn() async => await auth.currentUser?.uid != null;
  @override
  Future<void> signOut() async => auth.signOut();
  @override
  Future<void> verifyPhone({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  }) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  @override
  Future<UserCredential> signInWithCredential(AuthCredential credential) async {
    return auth.signInWithCredential(credential);
  }

  @override
  Future<void> createCurrentUser(CurrentUser user) async {
    final userCollection = _firebaseFirestore.collection('users');
    final String? uid = await auth.currentUser?.uid;
    final String? phoneNumber = await auth.currentUser?.phoneNumber;

    await userCollection.doc(uid).get().then((userDoc) {
      final newUser = CurrentUser(
        userId: uid ?? '',
        name: user.name,
        phoneNumber: phoneNumber ?? '',
        email: user.email,
      ).toDocument();
      if (!userDoc.exists) {
        //create new user
        userCollection.doc(uid).set(newUser);
      } else {
        //update user doc
        userCollection.doc(uid).update(newUser);
      }
    });
  }

  @override
  Future<CurrentUser> getCurrentUserInfo() async {
    final userCollection = _firebaseFirestore.collection('users');
    final String? uid = await auth.currentUser?.uid;

    return userCollection.doc(uid).get().then(CurrentUser.fromSnapShot);
  }

  @override
  Future<bool> phoneNumberExistsCheck(
    String phoneNumber,
  ) async {
    final String? uid = auth.currentUser?.uid;

    final userCollectionRef = await _firebaseFirestore
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get()
      ..docs;
    var mes = userCollectionRef.size;
    if (mes == 0) {
      return false;
    }

    return true;
  }

  @override
  Future<OAuthCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return credential;

    // await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
