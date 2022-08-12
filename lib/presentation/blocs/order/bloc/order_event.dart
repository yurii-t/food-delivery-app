part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class OrderLoad extends OrderEvent {}

class AddDish extends OrderEvent {
  final Menu dish;

  const AddDish(this.dish);

  @override
  List<Object> get props => [dish];
}

class RemoveDish extends OrderEvent {
  final Menu dish;

  const RemoveDish(this.dish);

  @override
  List<Object> get props => [dish];
}

class RemoveAllDishes extends OrderEvent {
  final Menu dish;

  const RemoveAllDishes(this.dish);

  @override
  List<Object> get props => [dish];
}

class AddBookingToFirebase extends OrderEvent {
  final Booking booking;

  const AddBookingToFirebase(this.booking);

  @override
  List<Object> get props => [booking];
}

class RateRestaurant extends OrderEvent {
  final String restaurantId;
  final num rating;

  const RateRestaurant(this.restaurantId, this.rating);
  @override
  List<Object> get props => [restaurantId, rating];
}
