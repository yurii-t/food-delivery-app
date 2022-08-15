import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/data/models/booking.dart';
import 'package:food_delivery_app/presentation/pages/profile/widgets/booking_list_item.dart';
import 'package:food_delivery_app/presentation/pages/profile/widgets/booking_order_bottom_sheet.dart';
import 'package:food_delivery_app/presentation/pages/profile/widgets/cancel_booking_bottom_sheet.dart';
import 'package:food_delivery_app/presentation/widgets/dash_separator.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class BookingDetailedPage extends StatelessWidget {
  final Booking booking;
  const BookingDetailedPage({required this.booking, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.lightGrey,
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 36),
        child: ListView(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => context.router.pop(),
                child: SvgPicture.asset(
                  'assets/icons/login_back_button.svg',
                  color: AppColors.grey,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              booking.restaurantName ?? 'Loading...',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BookingListItem(
              booking: booking,
              imageHeight: 206,
              titleSize: 0,
              subTitleSize: 0,
              enableIcons: false,
              statusTextSize: 14,
              isDetailedBooking: true,
            ),
            // Stack(
            //   children: [
            //     Container(
            //       height: 206,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(24),
            //         image: DecorationImage(
            //           image: NetworkImage(
            //             booking.restaurantImage ?? '',
            //           ),
            //           fit: BoxFit.fill,
            //         ),
            //       ),
            //     ),
            //     Container(
            //       padding:
            //           const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            //       margin: const EdgeInsets.all(10),
            //       decoration: BoxDecoration(
            //         color: Colors.green,
            //         borderRadius: BorderRadius.circular(6),
            //       ),
            //       child: Text(
            //         booking.status ?? 'Loading...',
            //         style: const TextStyle(
            //           color: Colors.white,
            //           fontWeight: FontWeight.w600,
            //           fontSize: 14,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Booking number - №12',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const DashSeparator(),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/calendar.svg',
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      DateFormat('dd.MM.yyyy')
                          .format(booking.bookedTime?.toDate() ?? DateTime(0)),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/clock.svg',
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      DateFormat('HH:mm').format(booking.bookedTime?.toDate() ??
                          DateTime(
                            0,
                          )),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/users.svg',
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        booking.numberofGuests.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const DashSeparator(),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/bill.svg',
                        color: AppColors.grey,
                        width: 17,
                        height: 17,
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      const Text(
                        '№19',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    right: 34,
                  ),
                  width: 1,
                  height: 48,
                  color: AppColors.grey,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet<Widget?>(
                      isScrollControlled: true,
                      useRootNavigator: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                      ),
                      context: context,
                      builder: (context) {
                        return BookingOrderBottomSheet(
                          orderedDishes: booking.dishes ?? [],
                          totalPrice: booking.totalPrice ?? 0,
                        );
                      },
                    );
                  },
                  child: const Text(
                    'View order',
                    style: TextStyle(
                      color: AppColors.darkBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const TextField(
              style: TextStyle(
                color: AppColors.grey,
              ),
              decoration: InputDecoration(
                hintText: 'Your comments',
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
              height: 39,
            ),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet<Widget?>(
                    useRootNavigator: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return CancelBookingBottomSheet(
                        booking: booking,
                      );
                    },
                  );
                },
                child: const Text(
                  'Cancel my booking',
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
