import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/data/models/booking.dart';
import 'package:food_delivery_app/presentation/blocs/booking/bloc/booking_bloc.dart';

class BookingImageStack extends StatelessWidget {
  final Booking booking;
  final double imageHeight;
  final double statusTextSize;
  final double radius;
  const BookingImageStack({
    required this.booking,
    required this.imageHeight,
    required this.statusTextSize,
    this.radius = 8,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          height: imageHeight,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: booking.restaurantImage != ''
              ? Image.network(
                  booking.restaurantImage ?? '',
                  fit: BoxFit.fill,
                )
              : const SizedBox.shrink(),
        ),
        BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            if (state is BookingLoaded) {
              final currentBooking = state.bookings.firstWhere(
                (element) => element.id == booking.id,
                orElse: () => booking,
              );

              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: currentBooking.status == 'Confirmed'
                      ? Colors.green
                      : Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  currentBooking.status ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: statusTextSize,
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
