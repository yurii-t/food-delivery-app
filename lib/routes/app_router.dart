import 'package:auto_route/auto_route.dart';
import 'package:food_delivery_app/presentation/pages/categories/categories_page.dart';
import 'package:food_delivery_app/presentation/pages/favorites/favorites_page.dart';
import 'package:food_delivery_app/presentation/pages/home/cafe/cafe_page.dart';
import 'package:food_delivery_app/presentation/pages/home/cafe/menu_page.dart';
import 'package:food_delivery_app/presentation/pages/home/cafe/time_select_page.dart';
import 'package:food_delivery_app/presentation/pages/home/cart/cart_page.dart';
import 'package:food_delivery_app/presentation/pages/home/home_page.dart';
import 'package:food_delivery_app/presentation/pages/home/map/map_page.dart';
import 'package:food_delivery_app/presentation/pages/login/enter_phone_page.dart';
import 'package:food_delivery_app/presentation/pages/login/enter_pin_page.dart';
import 'package:food_delivery_app/presentation/pages/login/information_page.dart';
import 'package:food_delivery_app/presentation/pages/profile/profile_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute<void>(
      page: EnterPhonePage,
      initial: true,
    ),
    AutoRoute<void>(page: EnterPinPage),
    AutoRoute<void>(page: InformationPage),
    AutoRoute<void>(page: CafePage),
    AutoRoute<void>(page: CartPage),
    AutoRoute<void>(page: MenuPage),
    AutoRoute<void>(page: TimeSelectPage),
    // AutoRoute<void>(
    //   page: FilesNavigationPage,
    //   children: [
    //     AutoRoute<void>(
    //       page: MediaPage,
    //     ),
    //     AutoRoute<void>(
    //       page: FilesPage,
    //     ),
    //   ],
    // ),
    AutoRoute<void>(
      page: HomePage,
      children: [
        AutoRoute<void>(
          page: MapPage,
        ),
        AutoRoute<void>(
          page: CategoriesPage,
        ),
        AutoRoute<void>(page: FavoritesPage),
        AutoRoute<void>(page: ProfilePage),
      ],
    ),
  ],
)
class $AppRouter {}
