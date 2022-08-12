// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'package:food_delivery_app/data/models/menu.dart';

class OrderedDishes extends Equatable {
  final Menu dish;
  final int quantity;

  const OrderedDishes({required this.dish, required this.quantity});

  OrderedDishes copyWith({
    Menu? dish,
    int? quantity,
  }) {
    return OrderedDishes(
      dish: dish ?? this.dish,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [dish, quantity];

  Map<String, dynamic> toDocument() {
    return <String, dynamic>{
      'dish': dish.toDocument(),
      'quantity': quantity,
    };
  }

  factory OrderedDishes.fromSnapShot(Map<String, dynamic> snap) {
    return OrderedDishes(
      dish: Menu.mapfromSnapShot(snap['dish'] as Map<String, dynamic>),
      quantity: snap['quantity'] as int,
    );
  }
}
