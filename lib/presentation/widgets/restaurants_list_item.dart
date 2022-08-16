import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/data/models/restaurant.dart';
import 'package:food_delivery_app/presentation/blocs/favorites/bloc/favorites_bloc.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class RestaurantsListItem extends StatelessWidget {
  final Restaurant restaurant;
  final bool isCategory;
  final double imageHeight;
  final double titleSize;
  final double subtitleSize;
  final bool isRestaurantCategory;
  const RestaurantsListItem({
    required this.restaurant,
    required this.isCategory,
    this.imageHeight = 138,
    this.titleSize = 16,
    this.subtitleSize = 11,
    this.isRestaurantCategory = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Container(
              height: imageHeight,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(restaurant.image),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            if (!isCategory)
              // if (isCategory == false)
              Align(
                alignment: Alignment.topRight,
                child: BlocBuilder<FavoritesBloc, FavoritesState>(
                  builder: (context, state) {
                    if (state is FavoritesLoaded) {
                      return GestureDetector(
                        onTap: () {
                          context
                              .read<FavoritesBloc>()
                              .add(AddFavorites(restaurant: restaurant));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: state.restaurants.contains(restaurant)
                              ? SvgPicture.asset(
                                  'assets/icons/favorite_fill.svg',
                                )
                              : SvgPicture.asset(
                                  'assets/icons/favorite.svg',
                                ),
                        ),
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
              )
            else
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  height: 25,
                  width: 44,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 5,
                              sigmaY: 5,
                            ),
                            child: Container(
                              height: 25,
                              width: 44,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/star.svg',
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    restaurant.rating.toStringAsFixed(1),
                                    // '${restaurant.rating}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                restaurant.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: !isCategory //isCategory == false
                      ? Colors.black
                      : isRestaurantCategory
                          ? Colors.black
                          : Colors.white,
                  fontSize: titleSize, // 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if (!isCategory)
              // if (isCategory == false)
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/star.svg',
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    restaurant.rating.toStringAsFixed(1),
                    // '${restaurant.rating}',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: subtitleSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            else
              const SizedBox.shrink(),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/icons/location.svg',
              width: 14,
              height: 14,
              color: AppColors.grey,
            ),
            const SizedBox(
              width: 8,
            ),
            Flexible(
              child: Text(
                restaurant.address,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
