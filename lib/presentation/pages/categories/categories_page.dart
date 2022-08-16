import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/presentation/blocs/categories/bloc/categories_bloc.dart';

import 'package:food_delivery_app/presentation/pages/categories/widgets/category_list_item.dart';

import 'package:food_delivery_app/presentation/widgets/restaurants_list_item.dart';
import 'package:food_delivery_app/routes/app_router.gr.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesLoaded) {
            final bestPlaces = state.categoryRestaurants
                .where((restaurant) => restaurant.rating >= 4.5)
                .toList();

            return ListView(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 80,
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 325,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/category_appbar_bg.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => context.router
                            .push(BestPlacesRoute(bestPlacesList: bestPlaces)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'See all',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            SvgPicture.asset(
                              'assets/icons/chevron_right.svg',
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemExtent: 280,
                          scrollDirection: Axis.horizontal,
                          itemCount: bestPlaces.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: RestaurantsListItem(
                                restaurant: bestPlaces[index],
                                isCategory: true,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: CategoryListItem(
                          category: state.categories[index],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                for (var category in state.categories)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: SizedBox(
                      height: 185,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () =>
                                context.router.push(SelectedCategoryRoute(
                              restaurantList: state.categoryRestaurants
                                  .where((restaurant) =>
                                      restaurant.category ==
                                      category.categoryName)
                                  .toList(),
                              category: category,
                            )),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      category.categoryNameIcon,
                                      style: const TextStyle(
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
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          SizedBox(
                            height: 149,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              itemExtent: 175,
                              scrollDirection: Axis.horizontal,
                              itemCount: state.categoryRestaurants
                                  .where((restaurant) =>
                                      restaurant.category ==
                                      category.categoryName)
                                  .toList()
                                  .length,
                              itemBuilder: (context, index) {
                                final restaurantList = state.categoryRestaurants
                                    .where((restaurant) =>
                                        restaurant.category ==
                                        category.categoryName)
                                    .toList();

                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 7),
                                  child: RestaurantsListItem(
                                    restaurant: restaurantList[index],
                                    imageHeight: 94,
                                    isCategory: true,
                                    titleSize: 12,
                                    subtitleSize: 10,
                                    isRestaurantCategory: true,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
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
    );
  }
}
