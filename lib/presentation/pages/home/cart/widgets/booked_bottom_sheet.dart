import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/models/booking.dart';

import 'package:food_delivery_app/presentation/pages/home/cart/widgets/rate_cafe_bottom_sheet.dart';
import 'package:food_delivery_app/routes/app_router.gr.dart';

import 'package:food_delivery_app/theme/app_colors.dart';

class BookedBottomSheet extends StatelessWidget {
  final String restaurantId;
  final Booking booking;
  const BookedBottomSheet(
      {required this.restaurantId, required this.booking, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void openRatingBottomSheet() {
      showModalBottomSheet<RateCafeBottomSheet?>(
        useRootNavigator: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        context: context,
        builder: (context) {
          return RateCafeBottomSheet(
            restaurantId: restaurantId,
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 40,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Your booking number - №12',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 29,
          ),
          const Text(
            'Order is booked. A manager will\ncontact you to confirm your booking. ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.darkGrey,
              fontSize: 14,
              fontWeight: FontWeight.w700,
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
                    Navigator.pop(context);

                    openRatingBottomSheet();
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
                    'Okay',
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
                    //     context.pushRoute(HomeRoute(userId: '', children: [
                    //   ProfileRouter(
                    //     children: [
                    //       ProfileRoute(),
                    //       BookingDetailedRoute(booking: booking),
                    //     ],
                    //   )
                    // ])),
                    context.replaceRoute(HomeRoute(userId: '', children: [
                      ProfileRouter(
                        children: [
                          ProfileRoute(),
                          BookingDetailedRoute(booking: booking),
                        ],
                      )
                    ]));
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
                    'View booking',
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
