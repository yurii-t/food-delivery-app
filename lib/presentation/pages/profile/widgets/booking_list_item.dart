import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/data/models/booking.dart';
import 'package:food_delivery_app/presentation/blocs/booking/bloc/booking_bloc.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class BookingListItem extends StatelessWidget {
  final Booking booking;
  final double imageHeight;
  final double titleSize;
  final double subTitleSize;
  final double statusTextSize;
  final bool enableIcons;

  const BookingListItem({
    required this.booking,
    required this.imageHeight,
    required this.titleSize,
    required this.subTitleSize,
    required this.enableIcons,
    required this.statusTextSize,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Container(
              height: imageHeight, //96,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(12),
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
                  final currentBooking = state.bookings
                      .firstWhere((element) => element == booking);

                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
                        fontSize: statusTextSize, // 10,
                      ),
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          booking.restaurantName ?? 'Loading',
          style: TextStyle(
            color: Colors.black,
            fontSize: titleSize, // 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        if (enableIcons)
          // if (enableIcons == true)
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/calendar.svg',
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                // '06.08.2021',
                DateFormat('dd.MM.yyyy')
                    .format(booking.bookedTime?.toDate() ?? DateTime(0)),
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: subTitleSize, //10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                width: 22,
              ),
              SvgPicture.asset(
                'assets/icons/clock.svg',
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                // ' 05:30',
                DateFormat('HH:mm').format(booking.bookedTime?.toDate() ??
                    DateTime(
                      0,
                    )),
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: subTitleSize, //10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        else
          Text(
            // '06.08.2021, 05:30',
            DateFormat('dd.MM.yyyy HH:mm')
                .format(booking.bookedTime?.toDate() ?? DateTime(0)),
            style: TextStyle(
              color: AppColors.grey,
              fontSize: subTitleSize, //10,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }
}
