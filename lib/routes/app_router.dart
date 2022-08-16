import 'package:auto_route/auto_route.dart';
import 'package:food_delivery_app/presentation/pages/categories/best_places_page.dart';
import 'package:food_delivery_app/presentation/pages/categories/categories_page.dart';
import 'package:food_delivery_app/presentation/pages/categories/selected_category_page.dart';
import 'package:food_delivery_app/presentation/pages/favorites/favorites_page.dart';
import 'package:food_delivery_app/presentation/pages/home/cafe/cafe_page.dart';
import 'package:food_delivery_app/presentation/pages/home/cafe/menu_page.dart';
import 'package:food_delivery_app/presentation/pages/home/cafe/time_select_page.dart';
import 'package:food_delivery_app/presentation/pages/home/cart/cart_page.dart';
import 'package:food_delivery_app/presentation/pages/home/home_page.dart';
import 'package:food_delivery_app/presentation/pages/home/map/map_page.dart';
import 'package:food_delivery_app/presentation/pages/login/auth_page.dart';
import 'package:food_delivery_app/presentation/pages/login/enter_phone_page.dart';
import 'package:food_delivery_app/presentation/pages/login/enter_pin_page.dart';
import 'package:food_delivery_app/presentation/pages/login/information_page.dart';
import 'package:food_delivery_app/presentation/pages/profile/profile.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute<void>(
      page: AuthPage,
      initial: true,
    ),
    AutoRoute<void>(
      page: EnterPhonePage,
    ),
    AutoRoute<void>(page: EnterPinPage),
    AutoRoute<void>(page: InformationPage),
    AutoRoute<void>(page: CafePage),
    AutoRoute<void>(page: CartPage),
    AutoRoute<void>(page: MenuPage),
    AutoRoute<void>(page: TimeSelectPage),
    AutoRoute<void>(
      page: HomePage,
      children: [
        AutoRoute<void>(
          page: MapPage,
        ),
        // AutoRoute<void>(
        //   page: CategoriesPage,
        // ),
        AutoRoute<void>(
          path: 'category',
          name: 'CategoryRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute<void>(path: '', page: CategoriesPage),
            AutoRoute<void>(page: SelectedCategoryPage),
            AutoRoute<void>(page: BestPlacesPage),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        AutoRoute<void>(page: FavoritesPage),
        AutoRoute<void>(
          path: 'profile',
          name: 'ProfileRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute<void>(path: '', page: ProfilePage),
            AutoRoute<void>(page: ProfileSettingsCardPage),
            AutoRoute<void>(page: ProfileSettingsPage),
            AutoRoute<void>(page: SupportServicePage),
            AutoRoute<void>(page: AboutApplicationPage),
            AutoRoute<void>(
              page: ProfileBookingPage,
            ),
            AutoRoute<void>(page: BookingDetailedPage),
            AutoRoute<void>(page: AddNewCardPage),
            AutoRoute<void>(page: SelectedCategoryPage),
            AutoRoute<void>(page: BestPlacesPage),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
      ],
    ),
  ],
)
class $AppRouter {}
