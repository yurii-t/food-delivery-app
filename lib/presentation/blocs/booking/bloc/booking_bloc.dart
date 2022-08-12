import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/data/datasource/firebase_remote_datasource_impl.dart';
import 'package:food_delivery_app/data/models/booking.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final FirebaseRemoteDataSourceImpl firebaseRemoteDataSourceImpl;
  BookingBloc(this.firebaseRemoteDataSourceImpl) : super(BookingInitial()) {
    on<LoadBooking>((event, emit) async {
      await emit.forEach(
        firebaseRemoteDataSourceImpl.getUserBooking(),
        onData: (bookings) => BookingLoaded(bookings as List<Booking>),
      );
    });

    on<CancelBooking>((event, emit) async {
      await firebaseRemoteDataSourceImpl.cancelBooking(event.booking);
    });
  }
}
