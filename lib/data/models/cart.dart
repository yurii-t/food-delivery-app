import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:food_delivery_app/data/models/menu.dart';

class Cart extends Equatable {
  final List<Menu> dishes;
  final String? restaurantName;
  final String? paymentMethod;
  final Timestamp? bookedTime;
  final num numberofGuests;

  const Cart({
    this.dishes = const <Menu>[],
    this.restaurantName,
    this.paymentMethod,
    this.bookedTime,
    this.numberofGuests = 1,
  });

  Cart copyWith({
    List<Menu>? dishes,
    String? restaurantName,
    String? paymentMethod,
    Timestamp? bookedTime,
    num? numberofGuests,
  }) {
    return Cart(
      dishes: dishes ?? this.dishes,
      restaurantName: restaurantName ?? this.restaurantName,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      bookedTime: bookedTime ?? this.bookedTime,
      numberofGuests: numberofGuests ?? this.numberofGuests,
    );
  }

  @override
  List<Object?> get props {
    return [
      dishes,
      restaurantName,
      paymentMethod,
      bookedTime,
      numberofGuests,
    ];
  }

  Map itemQuantity(List<Menu> dishes) {
    final quantity = <Menu, dynamic>{};

    dishes.forEach((item) {
      if (!quantity.containsKey(item)) {
        quantity[item] = 1;
      } else {
        quantity[item] += 1;
      }
    });

    return quantity;
  }

  double get totalPrice =>
      dishes.fold(0, (total, current) => total + current.dishPrice);
}
