import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:food_delivery_app/data/models/ordered_dishes.dart';

class Booking extends Equatable {
  final String? id;
  final List<OrderedDishes>? dishes;

  final String? restaurantName;
  final String? restaurantImage;
  final String? status;
  final num? totalPrice;
  final String? paymentMethod;
  final Timestamp? bookedTime;
  final num? numberofGuests;

  const Booking({
    this.id,
    this.dishes,
    this.restaurantName,
    this.restaurantImage,
    this.status,
    this.totalPrice,
    this.paymentMethod,
    this.bookedTime,
    this.numberofGuests = 1,
  });

  Booking copyWith({
    String? id,
    List<OrderedDishes>? dishes,
    String? restaurantName,
    String? restaurantImage,
    String? status,
    num? totalPrice,
    String? paymentMethod,
    Timestamp? bookedTime,
    num? numberofGuests,
  }) {
    return Booking(
      id: id ?? this.id,
      dishes: dishes ?? this.dishes,
      restaurantName: restaurantName ?? this.restaurantName,
      restaurantImage: restaurantImage ?? this.restaurantImage,
      status: status ?? this.status,
      totalPrice: totalPrice ?? this.totalPrice,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      bookedTime: bookedTime ?? this.bookedTime,
      numberofGuests: numberofGuests ?? this.numberofGuests,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      dishes,
      restaurantName,
      restaurantImage,
      status,
      totalPrice,
      paymentMethod,
      bookedTime,
      numberofGuests,
    ];
  }

  Map<String, dynamic> toDocument() {
    return <String, dynamic>{
      'id': id,
      'orderedDishes': dishes?.map((dish) => dish.toDocument()).toList(),
      'restaurantName': restaurantName,
      'restaurantImage': restaurantImage,
      'status': status,
      'totalPrice': totalPrice,
      'paymentMethod': paymentMethod,
      'bookedTime': bookedTime,
      'numberofGuests': numberofGuests,
    };
  }

  factory Booking.fromSnapShot(DocumentSnapshot snap) {
    final Booking booking = Booking(
      id: snap['id'] as String,
      dishes: (snap['orderedDishes'] as List).map((dynamic dish) {
        return OrderedDishes.fromSnapShot(dish as Map<String, dynamic>);
      }).toList(),
      restaurantName: snap['restaurantName'] as String,
      restaurantImage: snap['restaurantImage'] as String,
      status: snap['status'] as String,
      totalPrice: snap['totalPrice'] as num,
      paymentMethod: snap['paymentMethod'] as String,
      bookedTime: snap['bookedTime'] as Timestamp,
      numberofGuests: snap['numberofGuests'] as num,
    );

    return booking;
  }
}
