import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/data/models/restaurant.dart';
import 'package:food_delivery_app/data/models/restaurant_category.dart';
import 'package:food_delivery_app/presentation/widgets/restaurants_list_item.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class SelectedCategoryPage extends StatelessWidget {
  final List<Restaurant> restaurantList;
  final RestaurantCategory category;
  const SelectedCategoryPage({
    required this.restaurantList,
    required this.category,
    Key? key,
  }) : super(key: key);

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
            color: AppColors.orange,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    Text(
                      category.categoryName == 'pizza'
                          ? 'Tasty\npizza'
                          : category.categoryName == 'burgers'
                              ? 'True\nburgers'
                              : category.categoryName == 'sushi'
                                  ? 'Sushi'
                                  : category.categoryName == 'asian'
                                      ? 'Mama Mia,\nPasta bueno!'
                                      : 'Pasta',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'We found ${restaurantList.length} restaurants',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Image.network(
                category.image ?? '',
                width: 250,
                height: 250,
              ),
            ]),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.72,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: restaurantList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 7,
                    ),
                    child: RestaurantsListItem(
                      restaurant: restaurantList[index],
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
