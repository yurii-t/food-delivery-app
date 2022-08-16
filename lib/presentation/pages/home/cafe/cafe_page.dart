import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/data/models/restaurant.dart';
import 'package:food_delivery_app/presentation/blocs/favorites/bloc/favorites_bloc.dart';

import 'package:food_delivery_app/routes/app_router.gr.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class CafePage extends StatelessWidget {
  final Restaurant? restaurant;
  const CafePage({required this.restaurant, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<CafeInfo> cafeInfo = [
      CafeInfo(
        SvgPicture.asset(
          'assets/icons/location_marker.svg',
        ),
        restaurant?.address ?? '',
        Colors.black,
      ),
      CafeInfo(
        SvgPicture.asset(
          'assets/icons/clock.svg',
        ),
        restaurant?.workingTime ?? '',
        Colors.black,
      ),
      CafeInfo(
        SvgPicture.asset(
          'assets/icons/phone.svg',
        ),
        restaurant?.phoneNumber ?? '',
        Colors.black,
      ),
      CafeInfo(
        SvgPicture.asset(
          'assets/icons/clock.svg',
        ),
        restaurant?.orderPrepare ?? '',
        Colors.black,
      ),
      CafeInfo(
        SvgPicture.asset(
          'assets/icons/web.svg',
        ),
        restaurant?.webSite ?? '',
        AppColors.darkBlue,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    context.router.pop();
                  },
                  child: SvgPicture.asset(
                    'assets/icons/login_back_button.svg',
                    color: AppColors.grey,
                  ),
                ),
                GestureDetector(
                  onTap: () => context
                      .read<FavoritesBloc>()
                      .add(AddFavorites(restaurant: restaurant!)),
                  child: BlocBuilder<FavoritesBloc, FavoritesState>(
                    builder: (context, state) {
                      if (state is FavoritesLoaded) {
                        return state.restaurants.contains(restaurant)
                            ? SvgPicture.asset('assets/icons/favorite_fill.svg')
                            : SvgPicture.asset('assets/icons/like.svg');
                      }

                      return const Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    restaurant?.name ?? '',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/star.svg',
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      restaurant?.rating.toStringAsFixed(1) ?? '',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              restaurant?.options ?? '',
              style: const TextStyle(
                color: AppColors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 206,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(24),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    restaurant?.image ?? '',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 37,
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        height: 10,
                        width: 10,
                        child: CircularProgressIndicator(
                          value: (restaurant?.bookedSeats.toDouble() ?? 1) /
                              (restaurant?.totalSeats.toDouble() ?? 1),
                          color: AppColors.darkBlue,
                          backgroundColor: AppColors.grey,
                          strokeWidth: 2,
                        ),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Text(
                        'Free seats ${(restaurant?.totalSeats ?? 0) - (restaurant?.bookedSeats ?? 0)} / ${restaurant?.totalSeats}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    right: 34,
                    bottom: 2,
                  ),
                  width: 2,
                  height: 61,
                  color: AppColors.lightGrey,
                ),
                SvgPicture.asset(
                  'assets/icons/menu.svg',
                ),
                const SizedBox(
                  width: 7,
                ),
                GestureDetector(
                  onTap: () {
                    context.router.push(MenuRoute(
                      isOrder: false,
                      restaurantName: restaurant?.name ?? '',
                      restaurantId: restaurant?.id ?? '',
                      restaurantImage: restaurant?.image ?? '',
                    ));
                  },
                  child: const Text(
                    'Menu',
                    style: TextStyle(
                      color: AppColors.darkBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            for (final info in cafeInfo)
              Padding(
                padding: const EdgeInsets.only(bottom: 28),
                child: Row(
                  children: [
                    info.icon,
                    const SizedBox(
                      width: 14,
                    ),
                    Text(
                      info.text,
                      style: TextStyle(
                        color: info.textColors,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.router.push(TimeSelectRoute(
                        openHour: restaurant?.openHour ?? Timestamp.now(),
                        closeHour: restaurant?.closeHour ?? Timestamp.now(),
                        isOrder: false,
                        restaurantName: restaurant?.name ?? '',
                        restaurantId: restaurant?.id ?? '',
                        restaurantImage: restaurant?.image ?? '',
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.orange,
                      fixedSize: Size(MediaQuery.of(context).size.width, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Book a table'),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => null,
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.darkBlue,
                      fixedSize: Size(MediaQuery.of(context).size.width, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Make an order'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CafeInfo {
  final Widget icon;
  final String text;
  final Color textColors;

  CafeInfo(this.icon, this.text, this.textColors);
}
