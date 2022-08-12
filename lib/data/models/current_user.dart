import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/data/models/payment_method.dart';

class CurrentUser extends Equatable {
  final String userId;
  final String name;
  final String phoneNumber;
  final String email;
  final List<PaymentMethod>? paymentCards;
  final String? mainCard;

  const CurrentUser({
    required this.userId,
    required this.name,
    required this.phoneNumber,
    required this.email,
    this.paymentCards,
    this.mainCard,
  });

  factory CurrentUser.fromSnapShot(DocumentSnapshot snap) {
    final CurrentUser user = CurrentUser(
      userId: snap['userId'] as String,
      name: snap['name'] as String,
      phoneNumber: snap['phoneNumber'] as String,
      email: snap['email'] as String,
      paymentCards: (snap['paymentCards'] as List)
          .map((dynamic card) =>
              PaymentMethod.fromSnapShot(card as Map<String, dynamic>))
          .toList(),
      mainCard: snap['mainCard'] as String,
    );

    return user;
  }
  Map<String, Object> toDocument() {
    return {
      'userId': userId,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'paymentCards': paymentCards?.map((card) => card.toDocument()).toList() ??
          <PaymentMethod>[],
      'mainCard': mainCard ?? '',
    };
  }

  @override
  List<Object?> get props => [
        userId,
        name,
        phoneNumber,
        email,
        paymentCards,
        mainCard,
      ];
}
