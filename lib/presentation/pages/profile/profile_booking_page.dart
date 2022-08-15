import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/data/models/booking.dart';
import 'package:food_delivery_app/presentation/pages/profile/widgets/booking_list_item.dart';
import 'package:food_delivery_app/routes/app_router.gr.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class ProfileBookingPage extends StatelessWidget {
  final List<Booking> bookings;
  const ProfileBookingPage({required this.bookings, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.lightGrey,
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => context.router.pop(),
              child: SvgPicture.asset(
                'assets/icons/login_back_button.svg',
                color: AppColors.grey,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'My booking',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: GestureDetector(
                      onTap: () => context.router
                          .push(BookingDetailedRoute(booking: bookings[index])),
                      child: BookingListItem(
                        booking: bookings[index],
                        imageHeight: 138,
                        titleSize: 16,
                        subTitleSize: 12,
                        enableIcons: true,
                        statusTextSize: 12,
                        isDetailedBooking: false,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
