import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/data/datasource/firebase_remote_datasource_impl.dart';
import 'package:food_delivery_app/data/models/booking.dart';
import 'package:food_delivery_app/data/models/cart.dart';
import 'package:food_delivery_app/data/models/menu.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final FirebaseRemoteDataSourceImpl firebaseRemoteDataSourceImpl;
  // ignore: long-method
  OrderBloc(this.firebaseRemoteDataSourceImpl) : super(OrderInitial()) {
    on<OrderLoad>((event, emit) async {
      emit(OrderLoading());

      emit(const OrderLoaded(
        order: Cart(),
      ));
    });

    on<AddDish>((event, emit) async {
      final state = this.state;
      if (state is OrderLoaded) {
        emit(
          OrderLoaded(
            order: state.order.copyWith(
              dishes: List.from(state.order.dishes)..add(event.dish),
            ),
          ),
        );
      }
    });

    on<RemoveDish>((event, emit) async {
      final state = this.state;
      if (state is OrderLoaded) {
        emit(
          OrderLoaded(
            order: state.order.copyWith(
              dishes: List.from(state.order.dishes)..remove(event.dish),
            ),
          ),
        );
      }
    });

    on<RemoveAllDishes>((event, emit) async {
      final state = this.state;
      if (state is OrderLoaded) {
        emit(
          OrderLoaded(
            order: state.order.copyWith(
              dishes: List.from(state.order.dishes)
                ..removeWhere((dish) => dish == event.dish),
            ),
          ),
        );
      }
    });
    on<AddBookingToFirebase>((event, emit) async {
      await firebaseRemoteDataSourceImpl.sendBookingToFirebase(event.booking);
    });

    on<RateRestaurant>((event, emit) async {
      await firebaseRemoteDataSourceImpl.rateRestaurant(
        event.restaurantId,
        event.rating,
      );
    });
  }
}
