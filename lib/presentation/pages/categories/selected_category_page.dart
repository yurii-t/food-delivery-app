import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/data/models/restaurant.dart';
import 'package:food_delivery_app/data/models/restaurant_category.dart';
import 'package:food_delivery_app/presentation/widgets/restaurants_list_item.dart';
import 'package:food_delivery_app/theme/app_colors.dart';
import 'package:sliver_tools/sliver_tools.dart';

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
      body: CustomScrollView(
        slivers: [
          SliverStack(
            children: <Widget>[
              SliverPositioned(
                top: 0,
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 60,
                  ),
                  height: 280,
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.orange,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                  ? 'Tasty pizza'
                                  : category.categoryName == 'burgers'
                                      ? 'True burgers'
                                      : category.categoryName == 'sushi'
                                          ? 'Sushi'
                                          : category.categoryName == 'asian'
                                              ? 'Asian'
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
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(
                  top: 200,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: restaurantList.length,
                    (context, index) {
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
        ],
      ),
    );
  }
}
