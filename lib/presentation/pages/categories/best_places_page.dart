import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/data/models/restaurant.dart';
import 'package:food_delivery_app/presentation/widgets/restaurants_list_item.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class BestPlacesPage extends StatelessWidget {
  final List<Restaurant> bestPlacesList;
  const BestPlacesPage({required this.bestPlacesList, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16, top: 60),
            height: 280,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/best_places_appbar.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => context.router.pop(),
                  child: SvgPicture.asset(
                    'assets/icons/login_back_button.svg',
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  'Best places',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'We found ${bestPlacesList.length} restaurants',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.72,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: bestPlacesList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 7,
                    ),
                    child: RestaurantsListItem(
                      restaurant: bestPlacesList[index],
                      isCategory: false,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
