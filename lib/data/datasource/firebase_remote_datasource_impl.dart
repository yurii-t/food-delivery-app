import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery_app/data/datasource/firebase_remote_datasource.dart';
import 'package:food_delivery_app/data/models/booking.dart';
import 'package:food_delivery_app/data/models/current_user.dart';
import 'package:food_delivery_app/data/models/menu.dart';
import 'package:food_delivery_app/data/models/menu_category.dart';
import 'package:food_delivery_app/data/models/payment_method.dart';
import 'package:food_delivery_app/data/models/restaurant.dart';
import 'package:food_delivery_app/data/models/restaurant_category.dart';

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
    final userCollectionRef = await _firebaseFirestore
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get()
      ..docs;
    final mes = userCollectionRef.size;
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
  }

  @override
  Future<List<Restaurant>> getRestaurants() async {
    final restaurants =
        await _firebaseFirestore.collection('restaurants').get();

    return restaurants.docs.map(Restaurant.fromSnapShot).toList();
  }

  @override
  Future<List<Menu>> getMenu(String restarauntId) async {
    final restCollection = _firebaseFirestore.collection('restaurants');

    final menuItems =
        await restCollection.doc(restarauntId).collection('menu').get();

    return menuItems.docs.map(Menu.fromSnapShot).toList();
  }

  @override
  Future<List<MenuCategory>> getMenuCategories() async {
    final categoryCollection = _firebaseFirestore.collection('menuCategories');

    final categoryItems = await categoryCollection.get();

    return categoryItems.docs.map(MenuCategory.fromSnapShot).toList();
  }

  @override
  Future<List<RestaurantCategory>> getRestaurantCategories() async {
    final categoryCollection =
        _firebaseFirestore.collection('restaurantCategories');

    final categoryItems = await categoryCollection.get();

    return categoryItems.docs.map(RestaurantCategory.fromSnapShot).toList();
  }

  @override
  Future<void> sendBookingToFirebase(Booking booking) async {
    final String? uid = await auth.currentUser?.uid;
    await _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('orders')
        .add(booking.toDocument());
  }

  @override
  Stream<List<Booking>> getUserBooking() {
    final String? uid = auth.currentUser?.uid;
    final userCollectionRef = _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('orders')
        .orderBy('bookedTime', descending: true)
        .snapshots();

    return userCollectionRef
        .map((snapshot) => snapshot.docs.map(Booking.fromSnapShot).toList());
  }

  @override
  Future<void> updateUserInfo(String name, String email) async {
    final String? uid = await auth.currentUser?.uid;
    await _firebaseFirestore
        .collection('users')
        .doc(uid)
        .update({'name': name, 'email': email});
  }

  @override
  Future<void> updateMainCard(String cardNumber) async {
    final String? uid = await auth.currentUser?.uid;
    await _firebaseFirestore
        .collection('users')
        .doc(uid)
        .update({'mainCard': cardNumber});
  }

  @override
  Future<void> removeCard(PaymentMethod card) async {
    final String? uid = await auth.currentUser?.uid;

    await _firebaseFirestore.collection('users').doc(uid).update(
      {
        'paymentCards': FieldValue.arrayRemove(<dynamic>[card.toDocument()]),
      },
    );
  }

  @override
  Future<void> addCard(PaymentMethod card) async {
    final String? uid = await auth.currentUser?.uid;

    await _firebaseFirestore.collection('users').doc(uid).update(
      {
        'paymentCards': FieldValue.arrayUnion(<dynamic>[card.toDocument()]),
      },
    );
  }

  @override
  Future<void> addToFavorites(Restaurant restaurant) async {
    final String? uid = await auth.currentUser?.uid;

    final faveCol = await _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('favorites');

    final query = faveCol.where('id', isEqualTo: restaurant.id);
    final snap = await query.get();

    if (snap.docs.isNotEmpty) {
      final ref = snap.docs.map((e) => e.reference).first;

      await _firebaseFirestore.runTransaction((transaction) async {
        transaction.delete(ref);
      });
    } else {
      await faveCol.add(
        restaurant.toDocument(),
      );
    }
  }

  @override
  Stream<List<Restaurant>> getFavorites() {
    final String? uid = auth.currentUser?.uid;
    final userCollectionRef = _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .snapshots();

    return userCollectionRef
        .map((snapshot) => snapshot.docs.map(Restaurant.fromSnapShot).toList());
  }

  @override
  Future<void> rateRestaurant(
    String restaurantId,
    num rating,
  ) async {
    final String? uid = await auth.currentUser?.uid;

    final restCol = await _firebaseFirestore
        .collection('restaurants')
        .doc(restaurantId)
        .collection('rating');

    final query = await restCol.where('id', isEqualTo: uid);
    final snap = await query.get();
    if (snap.docs.isEmpty) {
      await restCol.add(<String, dynamic>{'id': uid, 'rating': rating});
    } else {
      await restCol
          .doc(snap.docs.first.id)
          .update(<String, dynamic>{'id': uid, 'rating': rating});
    }
  }

  @override
  Future<void> cancelBooking(Booking booking) async {
    final String? uid = await auth.currentUser?.uid;
    final userCollectionRef = await _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('orders');
    final query = await userCollectionRef.where('id', isEqualTo: booking.id);

    final snap = await query.get();

    final ref = userCollectionRef.doc(snap.docs.map((e) => e.id).first);
    await userCollectionRef.doc(ref.id).update({'status': 'Canceled'});
  }

  @override
  Future<void> sendSupportMessage(
    String email,
    String message,
  ) async {
    final String? uid = await auth.currentUser?.uid;

    await _firebaseFirestore
        .collection('support')
        .add(<String, dynamic>{'id': uid, 'email': email, 'message': message});
  }
}
