import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/presentation/blocs/bottombar/bloc/bottombar_bloc.dart';
import 'package:food_delivery_app/presentation/widgets/bottom_bar_active_icon.dart';
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
        ProfileRouter(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BlocBuilder<BottombarBloc, BottombarState>(
          builder: (context, state) {
            if (state is BottombarLoaded) {
              return !state.hide
                  ? SizedBox(
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
                            activeIcon: BottomBarActiveIcon(
                              icon: SvgPicture.asset(
                                'assets/icons/location.svg',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          BottomNavigationBarItem(
                            label: '',
                            icon: SvgPicture.asset(
                              'assets/icons/category.svg',
                            ),
                            activeIcon: BottomBarActiveIcon(
                              icon: SvgPicture.asset(
                                'assets/icons/category.svg',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          BottomNavigationBarItem(
                            label: '',
                            icon: SvgPicture.asset(
                              'assets/icons/favorite.svg',
                            ),
                            activeIcon: BottomBarActiveIcon(
                              icon: SvgPicture.asset(
                                'assets/icons/favorite.svg',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          BottomNavigationBarItem(
                            label: '',
                            icon: SvgPicture.asset(
                              'assets/icons/profile.svg',
                            ),
                            activeIcon: BottomBarActiveIcon(
                              icon: SvgPicture.asset(
                                'assets/icons/profile.svg',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink();
            }

            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}
