import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery_app/data/models/booking.dart';
import 'package:food_delivery_app/data/models/current_user.dart';
import 'package:food_delivery_app/data/models/menu.dart';
import 'package:food_delivery_app/data/models/menu_category.dart';
import 'package:food_delivery_app/data/models/payment_method.dart';
import 'package:food_delivery_app/data/models/restaurant.dart';
import 'package:food_delivery_app/data/models/restaurant_category.dart';

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
  Future<List<Restaurant>> getRestaurants();
  Stream<List<Restaurant>> getRestaurantsStream();
  Future<List<Menu>> getMenu(String restarauntId);
  Future<List<MenuCategory>> getMenuCategories();
  Future<List<RestaurantCategory>> getRestaurantCategories();
  Future<void> sendBookingToFirebase(Booking booking);
  Stream<List<Booking>> getUserBooking();
  Future<void> addToFavorites(Restaurant restaurant);
  Stream<List<Restaurant>> getFavorites();
  Future<void> sendSupportMessage(
    String email,
    String message,
  );
  Future<void> cancelBooking(Booking booking);
  Future<void> rateRestaurant(
    String restaurantId,
    num rating,
  );
  Future<void> addCard(PaymentMethod card);
  Future<void> removeCard(PaymentMethod card);
  Future<void> updateMainCard(String cardNumber);
  Future<void> updateUserInfo(String name, String email);
}
