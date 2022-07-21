import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CurrentUser extends Equatable {
  final String userId;
  final String name;
  final String phoneNumber;
  final String email;

  const CurrentUser(
      {required this.userId,
      required this.name,
      required this.phoneNumber,
      required this.email});

  factory CurrentUser.fromSnapShot(QueryDocumentSnapshot snap) {
    final CurrentUser user = CurrentUser(
      userId: snap['userId'] as String,
      name: snap['name'] as String,
      phoneNumber: snap['phoneNumber'] as String,
      email: snap['email'] as String,
    );
    return user;
  }
  Map<String, Object> toDocument() {
    return {
      'userId': userId,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }

  @override
  List<Object?> get props => [
        userId,
        name,
        phoneNumber,
        email,
      ];
}
