import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:food_delivery_app/data/models/restaurant_category.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class CategoryListItem extends StatelessWidget {
  final RestaurantCategory category;
  const CategoryListItem({required this.category, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Container(
              width: 98,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.orange,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Positioned(
              right: 0,
              bottom: -10,
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    bottom: -15,
                    width: 100,
                    height: 100,
                    child: Opacity(
                      child: Image.network(
                        category.image ?? '',
                        width: 100,
                        height: 100,
                        color: Colors.black,
                      ),
                      opacity: 0.2,
                    ),
                  ),
                  ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5,
                        sigmaY: 5,
                      ),
                      child: Image.network(
                        category.image ?? '',
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Text(
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
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
