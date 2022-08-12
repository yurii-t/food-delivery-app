import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/presentation/blocs/favorites/bloc/favorites_bloc.dart';
import 'package:food_delivery_app/presentation/widgets/restaurants_list_item.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 60, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Favorites',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          BlocBuilder<FavoritesBloc, FavoritesState>(
            builder: (context, state) {
              if (state is FavoritesLoading) {
                return const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is FavoritesLoaded) {
                return Expanded(
                  child: state.restaurants.isNotEmpty
                      ? ListView.builder(
                          itemCount: state.restaurants.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: RestaurantsListItem(
                                restaurant: state.restaurants[index],
                                isCategory: false,
                              ),
                            );
                          },
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Spacer(),
                            SvgPicture.asset(
                              'assets/icons/empty_favorite.svg',
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            const Text(
                              'Oops... There are no favourites yet',
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                context.router.popUntilRoot();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: AppColors.orange,
                                fixedSize:
                                    Size(MediaQuery.of(context).size.width, 52),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Explore new places',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
