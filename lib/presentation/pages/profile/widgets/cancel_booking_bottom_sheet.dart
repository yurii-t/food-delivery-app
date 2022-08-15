import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/data/models/booking.dart';
import 'package:food_delivery_app/presentation/blocs/booking/bloc/booking_bloc.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class CancelBookingBottomSheet extends StatelessWidget {
  final Booking booking;
  const CancelBookingBottomSheet({required this.booking, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 40,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Do you really want to cancel? ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 29,
          ),
          const TextField(
            style: TextStyle(
              color: AppColors.grey,
            ),
            decoration: InputDecoration(
              hintText: 'Specify the reason',
              focusColor: Colors.white,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.grey, width: 2),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.grey, width: 2),
              ),
            ),
          ),
          const SizedBox(
            height: 29,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.router.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    enableFeedback: false,
                    side: BorderSide.none,
                    elevation: 0,
                    primary: Colors.transparent,
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      52,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide.none,
                    ),
                  ),
                  child: const Text(
                    'No',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<BookingBloc>().add(CancelBooking(booking));
                  },
                  style: ElevatedButton.styleFrom(
                    side: BorderSide.none,
                    elevation: 0,
                    primary: AppColors.orange,
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      52,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide.none,
                    ),
                  ),
                  child: const Text(
                    'Yes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
