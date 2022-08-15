import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/data/models/booking.dart';
import 'package:food_delivery_app/presentation/blocs/auth_status/bloc/auth_status_bloc.dart';
import 'package:food_delivery_app/presentation/blocs/booking/bloc/booking_bloc.dart';
import 'package:food_delivery_app/presentation/blocs/user/bloc/user_bloc.dart';

import 'package:food_delivery_app/presentation/pages/profile/widgets/booking_list_item.dart';
import 'package:food_delivery_app/presentation/pages/profile/widgets/profile_divider.dart';
import 'package:food_delivery_app/presentation/widgets/quantity_operation_container.dart';
import 'package:food_delivery_app/routes/app_router.gr.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Booking> bookings = [];

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is BookingLoading) {
            return const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is UserLoaded) {
            final List<ProfileOptions> optionsList = [
              ProfileOptions(
                text: 'Geolocation',
                icon: SvgPicture.asset(
                  'assets/icons/chevron_right.svg',
                ),
                function: () => context.router.push(const AddNewCardRoute()),
              ),
              ProfileOptions(
                text: 'Payment method',
                icon: SvgPicture.asset(
                  'assets/icons/chevron_right.svg',
                ),
                function: () => context.router.push(ProfileSettingsCardRoute(
                  paymentCard: state.usersInfo.paymentCards ?? [],
                  mainCard: state.usersInfo.mainCard ?? '',
                )),
              ),
              ProfileOptions(
                text: 'Support Service',
                icon: SvgPicture.asset(
                  'assets/icons/chevron_right.svg',
                ),
                function: () =>
                    context.router.push(const SupportServiceRoute()),
              ),
              ProfileOptions(
                text: 'About the application',
                icon: SvgPicture.asset(
                  'assets/icons/chevron_right.svg',
                ),
                function: () =>
                    context.router.push(const AboutApplicationRoute()),
              ),
              ProfileOptions(
                text: 'View onboarding',
                icon: SvgPicture.asset(
                  'assets/icons/chevron_right.svg',
                ),
              ),
              ProfileOptions(
                text: 'Log out',
                icon: SvgPicture.asset(
                  'assets/icons/exit.svg',
                ),
                function: () =>
                    context.read<AuthStatusBloc>().add(AuthStatusLogedOut()),
              ),
            ];

            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15, top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.usersInfo.name.isEmpty
                            ? 'Set your name'
                            : state.usersInfo.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        state.usersInfo.email.isEmpty
                            ? 'Set your email'
                            : state.usersInfo.email,
                        style: const TextStyle(
                          color: AppColors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              state.usersInfo.phoneNumber,
                              style: const TextStyle(
                                color: AppColors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.router.push(
                              ProfileSettingsRoute(
                                userInfo: state.usersInfo,
                              ),
                            ),
                            child: QuantityOperationContainer(
                              icon: SvgPicture.asset(
                                'assets/icons/edit.svg',
                              ),
                              size: 37,
                              shadow: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        thickness: 1,
                        color: AppColors.grey,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () => context.router
                            .push(ProfileBookingRoute(bookings: bookings)),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'My bookings',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/icons/chevron_right.svg',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<BookingBloc, BookingState>(
                  builder: (context, state) {
                    if (state is BookingLoading) {
                      return const Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (state is BookingLoaded) {
                      bookings = state.bookings;

                      return SizedBox(
                        height: 168,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.bookings.length,
                          clipBehavior: Clip.none,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.only(left: 16),
                              width: 254,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: BookingListItem(
                                booking: state.bookings[index],
                                imageHeight: 96,
                                titleSize: 12,
                                subTitleSize: 10,
                                enableIcons: false,
                                statusTextSize: 10,
                                isDetailedBooking: false,
                              ),
                            );
                          },
                        ),
                      );
                    }

                    return const Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const ProfileDivider(),
                const SizedBox(
                  height: 10,
                ),
                for (var option in optionsList)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: option.function,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  option.text,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              option.icon,
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (option == optionsList.last)
                          const SizedBox.shrink()
                        else
                          const ProfileDivider(),
                      ],
                    ),
                  ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class ProfileOptions {
  final String text;
  final Widget icon;
  final VoidCallback? function;

  ProfileOptions({required this.text, required this.icon, this.function});
}
