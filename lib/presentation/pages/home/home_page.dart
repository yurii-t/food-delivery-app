import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/routes/app_router.gr.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class HomePage extends StatelessWidget {
  final String userId;
  const HomePage({required this.userId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        MapRoute(),
        CategoriesRoute(),
        FavoritesRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return SizedBox(
          height: 90,
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            selectedItemColor: AppColors.orange,
            items: [
              BottomNavigationBarItem(
                label: '',
                icon: SvgPicture.asset(
                  'assets/icons/location.svg',
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/location.svg',
                  // color: AppColors.orange,
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: SvgPicture.asset(
                  'assets/icons/category.svg',
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/category.svg',
                  // color: AppColors.green,
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: SvgPicture.asset(
                  'assets/icons/favorite.svg',
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/favorite.svg',
                  // color: AppColors.green,
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: SvgPicture.asset(
                  'assets/icons/profile.svg',
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/profile.svg',
                  // color: AppColors.green,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
