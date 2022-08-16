// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i11;
import 'package:cloud_firestore/cloud_firestore.dart' as _i19;
import 'package:flutter/material.dart' as _i17;

import '../data/models/booking.dart' as _i23;
import '../data/models/current_user.dart' as _i22;
import '../data/models/payment_method.dart' as _i21;
import '../data/models/restaurant.dart' as _i18;
import '../data/models/restaurant_category.dart' as _i20;
import '../presentation/pages/categories/best_places_page.dart' as _i15;
import '../presentation/pages/categories/categories_page.dart' as _i13;
import '../presentation/pages/categories/selected_category_page.dart' as _i14;
import '../presentation/pages/favorites/favorites_page.dart' as _i12;
import '../presentation/pages/home/cafe/cafe_page.dart' as _i5;
import '../presentation/pages/home/cafe/menu_page.dart' as _i7;
import '../presentation/pages/home/cafe/time_select_page.dart' as _i8;
import '../presentation/pages/home/cart/cart_page.dart' as _i6;
import '../presentation/pages/home/home_page.dart' as _i9;
import '../presentation/pages/home/map/map_page.dart' as _i10;
import '../presentation/pages/login/auth_page.dart' as _i1;
import '../presentation/pages/login/enter_phone_page.dart' as _i2;
import '../presentation/pages/login/enter_pin_page.dart' as _i3;
import '../presentation/pages/login/information_page.dart' as _i4;
import '../presentation/pages/profile/profile.dart' as _i16;

class AppRouter extends _i11.RootStackRouter {
  AppRouter([_i17.GlobalKey<_i17.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i1.AuthPage());
    },
    EnterPhoneRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i2.EnterPhonePage());
    },
    EnterPinRoute.name: (routeData) {
      final args = routeData.argsAs<EnterPinRouteArgs>();
      return _i11.MaterialPageX<void>(
          routeData: routeData,
          child: _i3.EnterPinPage(
              verId: args.verId,
              isRegistration: args.isRegistration,
              phoneNumber: args.phoneNumber,
              key: args.key));
    },
    InformationRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i4.InformationPage());
    },
    CafeRoute.name: (routeData) {
      final args = routeData.argsAs<CafeRouteArgs>();
      return _i11.MaterialPageX<void>(
          routeData: routeData,
          child: _i5.CafePage(restaurant: args.restaurant, key: args.key));
    },
    CartRoute.name: (routeData) {
      final args = routeData.argsAs<CartRouteArgs>();
      return _i11.MaterialPageX<void>(
          routeData: routeData,
          child: _i6.CartPage(
              restaurantId: args.restaurantId,
              restaurantName: args.restaurantName,
              restaurantImage: args.restaurantImage,
              bookedTime: args.bookedTime,
              numberofGuests: args.numberofGuests,
              key: args.key));
    },
    MenuRoute.name: (routeData) {
      final args = routeData.argsAs<MenuRouteArgs>();
      return _i11.MaterialPageX<void>(
          routeData: routeData,
          child: _i7.MenuPage(
              isOrder: args.isOrder,
              restaurantId: args.restaurantId,
              restaurantName: args.restaurantName,
              restaurantImage: args.restaurantImage,
              selectedDate: args.selectedDate,
              numberOfGuests: args.numberOfGuests,
              key: args.key));
    },
    TimeSelectRoute.name: (routeData) {
      final args = routeData.argsAs<TimeSelectRouteArgs>();
      return _i11.MaterialPageX<void>(
          routeData: routeData,
          child: _i8.TimeSelectPage(
              openHour: args.openHour,
              closeHour: args.closeHour,
              isOrder: args.isOrder,
              restaurantId: args.restaurantId,
              restaurantName: args.restaurantName,
              restaurantImage: args.restaurantImage,
              key: args.key));
    },
    HomeRoute.name: (routeData) {
      final args = routeData.argsAs<HomeRouteArgs>();
      return _i11.MaterialPageX<void>(
          routeData: routeData,
          child: _i9.HomePage(userId: args.userId, key: args.key));
    },
    MapRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i10.MapPage());
    },
    CategoryRouter.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i11.EmptyRouterPage());
    },
    FavoritesRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i12.FavoritesPage());
    },
    ProfileRouter.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i11.EmptyRouterPage());
    },
    CategoriesRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i13.CategoriesPage());
    },
    SelectedCategoryRoute.name: (routeData) {
      final args = routeData.argsAs<SelectedCategoryRouteArgs>();
      return _i11.MaterialPageX<void>(
          routeData: routeData,
          child: _i14.SelectedCategoryPage(
              restaurantList: args.restaurantList,
              category: args.category,
              key: args.key));
    },
    BestPlacesRoute.name: (routeData) {
      final args = routeData.argsAs<BestPlacesRouteArgs>();
      return _i11.MaterialPageX<void>(
          routeData: routeData,
          child: _i15.BestPlacesPage(
              bestPlacesList: args.bestPlacesList, key: args.key));
    },
    ProfileRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i16.ProfilePage());
    },
    ProfileSettingsCardRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileSettingsCardRouteArgs>();
      return _i11.MaterialPageX<void>(
          routeData: routeData,
          child: _i16.ProfileSettingsCardPage(
              paymentCard: args.paymentCard,
              mainCard: args.mainCard,
              key: args.key));
    },
    ProfileSettingsRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileSettingsRouteArgs>();
      return _i11.MaterialPageX<void>(
          routeData: routeData,
          child:
              _i16.ProfileSettingsPage(userInfo: args.userInfo, key: args.key));
    },
    SupportServiceRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i16.SupportServicePage());
    },
    AboutApplicationRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i16.AboutApplicationPage());
    },
    ProfileBookingRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileBookingRouteArgs>();
      return _i11.MaterialPageX<void>(
          routeData: routeData,
          child:
              _i16.ProfileBookingPage(bookings: args.bookings, key: args.key));
    },
    BookingDetailedRoute.name: (routeData) {
      final args = routeData.argsAs<BookingDetailedRouteArgs>();
      return _i11.MaterialPageX<void>(
          routeData: routeData,
          child:
              _i16.BookingDetailedPage(booking: args.booking, key: args.key));
    },
    AddNewCardRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i16.AddNewCardPage());
    }
  };

  @override
  List<_i11.RouteConfig> get routes => [
        _i11.RouteConfig(AuthRoute.name, path: '/'),
        _i11.RouteConfig(EnterPhoneRoute.name, path: '/enter-phone-page'),
        _i11.RouteConfig(EnterPinRoute.name, path: '/enter-pin-page'),
        _i11.RouteConfig(InformationRoute.name, path: '/information-page'),
        _i11.RouteConfig(CafeRoute.name, path: '/cafe-page'),
        _i11.RouteConfig(CartRoute.name, path: '/cart-page'),
        _i11.RouteConfig(MenuRoute.name, path: '/menu-page'),
        _i11.RouteConfig(TimeSelectRoute.name, path: '/time-select-page'),
        _i11.RouteConfig(HomeRoute.name, path: '/home-page', children: [
          _i11.RouteConfig(MapRoute.name,
              path: 'map-page', parent: HomeRoute.name),
          _i11.RouteConfig(CategoryRouter.name,
              path: 'category',
              parent: HomeRoute.name,
              children: [
                _i11.RouteConfig(CategoriesRoute.name,
                    path: '', parent: CategoryRouter.name),
                _i11.RouteConfig(SelectedCategoryRoute.name,
                    path: 'selected-category-page',
                    parent: CategoryRouter.name),
                _i11.RouteConfig(BestPlacesRoute.name,
                    path: 'best-places-page', parent: CategoryRouter.name),
                _i11.RouteConfig('*#redirect',
                    path: '*',
                    parent: CategoryRouter.name,
                    redirectTo: '',
                    fullMatch: true)
              ]),
          _i11.RouteConfig(FavoritesRoute.name,
              path: 'favorites-page', parent: HomeRoute.name),
          _i11.RouteConfig(ProfileRouter.name,
              path: 'profile',
              parent: HomeRoute.name,
              children: [
                _i11.RouteConfig(ProfileRoute.name,
                    path: '', parent: ProfileRouter.name),
                _i11.RouteConfig(ProfileSettingsCardRoute.name,
                    path: 'profile-settings-card-page',
                    parent: ProfileRouter.name),
                _i11.RouteConfig(ProfileSettingsRoute.name,
                    path: 'profile-settings-page', parent: ProfileRouter.name),
                _i11.RouteConfig(SupportServiceRoute.name,
                    path: 'support-service-page', parent: ProfileRouter.name),
                _i11.RouteConfig(AboutApplicationRoute.name,
                    path: 'about-application-page', parent: ProfileRouter.name),
                _i11.RouteConfig(ProfileBookingRoute.name,
                    path: 'profile-booking-page', parent: ProfileRouter.name),
                _i11.RouteConfig(BookingDetailedRoute.name,
                    path: 'booking-detailed-page', parent: ProfileRouter.name),
                _i11.RouteConfig(AddNewCardRoute.name,
                    path: 'add-new-card-page', parent: ProfileRouter.name),
                _i11.RouteConfig(SelectedCategoryRoute.name,
                    path: 'selected-category-page', parent: ProfileRouter.name),
                _i11.RouteConfig(BestPlacesRoute.name,
                    path: 'best-places-page', parent: ProfileRouter.name),
                _i11.RouteConfig('*#redirect',
                    path: '*',
                    parent: ProfileRouter.name,
                    redirectTo: '',
                    fullMatch: true)
              ])
        ])
      ];
}

/// generated route for
/// [_i1.AuthPage]
class AuthRoute extends _i11.PageRouteInfo<void> {
  const AuthRoute() : super(AuthRoute.name, path: '/');

  static const String name = 'AuthRoute';
}

/// generated route for
/// [_i2.EnterPhonePage]
class EnterPhoneRoute extends _i11.PageRouteInfo<void> {
  const EnterPhoneRoute()
      : super(EnterPhoneRoute.name, path: '/enter-phone-page');

  static const String name = 'EnterPhoneRoute';
}

/// generated route for
/// [_i3.EnterPinPage]
class EnterPinRoute extends _i11.PageRouteInfo<EnterPinRouteArgs> {
  EnterPinRoute(
      {required String verId,
      required bool isRegistration,
      required String phoneNumber,
      _i17.Key? key})
      : super(EnterPinRoute.name,
            path: '/enter-pin-page',
            args: EnterPinRouteArgs(
                verId: verId,
                isRegistration: isRegistration,
                phoneNumber: phoneNumber,
                key: key));

  static const String name = 'EnterPinRoute';
}

class EnterPinRouteArgs {
  const EnterPinRouteArgs(
      {required this.verId,
      required this.isRegistration,
      required this.phoneNumber,
      this.key});

  final String verId;

  final bool isRegistration;

  final String phoneNumber;

  final _i17.Key? key;

  @override
  String toString() {
    return 'EnterPinRouteArgs{verId: $verId, isRegistration: $isRegistration, phoneNumber: $phoneNumber, key: $key}';
  }
}

/// generated route for
/// [_i4.InformationPage]
class InformationRoute extends _i11.PageRouteInfo<void> {
  const InformationRoute()
      : super(InformationRoute.name, path: '/information-page');

  static const String name = 'InformationRoute';
}

/// generated route for
/// [_i5.CafePage]
class CafeRoute extends _i11.PageRouteInfo<CafeRouteArgs> {
  CafeRoute({required _i18.Restaurant? restaurant, _i17.Key? key})
      : super(CafeRoute.name,
            path: '/cafe-page',
            args: CafeRouteArgs(restaurant: restaurant, key: key));

  static const String name = 'CafeRoute';
}

class CafeRouteArgs {
  const CafeRouteArgs({required this.restaurant, this.key});

  final _i18.Restaurant? restaurant;

  final _i17.Key? key;

  @override
  String toString() {
    return 'CafeRouteArgs{restaurant: $restaurant, key: $key}';
  }
}

/// generated route for
/// [_i6.CartPage]
class CartRoute extends _i11.PageRouteInfo<CartRouteArgs> {
  CartRoute(
      {required String restaurantId,
      required String restaurantName,
      required String restaurantImage,
      required _i19.Timestamp bookedTime,
      required num numberofGuests,
      _i17.Key? key})
      : super(CartRoute.name,
            path: '/cart-page',
            args: CartRouteArgs(
                restaurantId: restaurantId,
                restaurantName: restaurantName,
                restaurantImage: restaurantImage,
                bookedTime: bookedTime,
                numberofGuests: numberofGuests,
                key: key));

  static const String name = 'CartRoute';
}

class CartRouteArgs {
  const CartRouteArgs(
      {required this.restaurantId,
      required this.restaurantName,
      required this.restaurantImage,
      required this.bookedTime,
      required this.numberofGuests,
      this.key});

  final String restaurantId;

  final String restaurantName;

  final String restaurantImage;

  final _i19.Timestamp bookedTime;

  final num numberofGuests;

  final _i17.Key? key;

  @override
  String toString() {
    return 'CartRouteArgs{restaurantId: $restaurantId, restaurantName: $restaurantName, restaurantImage: $restaurantImage, bookedTime: $bookedTime, numberofGuests: $numberofGuests, key: $key}';
  }
}

/// generated route for
/// [_i7.MenuPage]
class MenuRoute extends _i11.PageRouteInfo<MenuRouteArgs> {
  MenuRoute(
      {required bool isOrder,
      required String restaurantId,
      required String restaurantName,
      required String restaurantImage,
      DateTime? selectedDate,
      num? numberOfGuests,
      _i17.Key? key})
      : super(MenuRoute.name,
            path: '/menu-page',
            args: MenuRouteArgs(
                isOrder: isOrder,
                restaurantId: restaurantId,
                restaurantName: restaurantName,
                restaurantImage: restaurantImage,
                selectedDate: selectedDate,
                numberOfGuests: numberOfGuests,
                key: key));

  static const String name = 'MenuRoute';
}

class MenuRouteArgs {
  const MenuRouteArgs(
      {required this.isOrder,
      required this.restaurantId,
      required this.restaurantName,
      required this.restaurantImage,
      this.selectedDate,
      this.numberOfGuests,
      this.key});

  final bool isOrder;

  final String restaurantId;

  final String restaurantName;

  final String restaurantImage;

  final DateTime? selectedDate;

  final num? numberOfGuests;

  final _i17.Key? key;

  @override
  String toString() {
    return 'MenuRouteArgs{isOrder: $isOrder, restaurantId: $restaurantId, restaurantName: $restaurantName, restaurantImage: $restaurantImage, selectedDate: $selectedDate, numberOfGuests: $numberOfGuests, key: $key}';
  }
}

/// generated route for
/// [_i8.TimeSelectPage]
class TimeSelectRoute extends _i11.PageRouteInfo<TimeSelectRouteArgs> {
  TimeSelectRoute(
      {required _i19.Timestamp openHour,
      required _i19.Timestamp closeHour,
      required bool isOrder,
      required String restaurantId,
      required String restaurantName,
      required String restaurantImage,
      _i17.Key? key})
      : super(TimeSelectRoute.name,
            path: '/time-select-page',
            args: TimeSelectRouteArgs(
                openHour: openHour,
                closeHour: closeHour,
                isOrder: isOrder,
                restaurantId: restaurantId,
                restaurantName: restaurantName,
                restaurantImage: restaurantImage,
                key: key));

  static const String name = 'TimeSelectRoute';
}

class TimeSelectRouteArgs {
  const TimeSelectRouteArgs(
      {required this.openHour,
      required this.closeHour,
      required this.isOrder,
      required this.restaurantId,
      required this.restaurantName,
      required this.restaurantImage,
      this.key});

  final _i19.Timestamp openHour;

  final _i19.Timestamp closeHour;

  final bool isOrder;

  final String restaurantId;

  final String restaurantName;

  final String restaurantImage;

  final _i17.Key? key;

  @override
  String toString() {
    return 'TimeSelectRouteArgs{openHour: $openHour, closeHour: $closeHour, isOrder: $isOrder, restaurantId: $restaurantId, restaurantName: $restaurantName, restaurantImage: $restaurantImage, key: $key}';
  }
}

/// generated route for
/// [_i9.HomePage]
class HomeRoute extends _i11.PageRouteInfo<HomeRouteArgs> {
  HomeRoute(
      {required String userId,
      _i17.Key? key,
      List<_i11.PageRouteInfo>? children})
      : super(HomeRoute.name,
            path: '/home-page',
            args: HomeRouteArgs(userId: userId, key: key),
            initialChildren: children);

  static const String name = 'HomeRoute';
}

class HomeRouteArgs {
  const HomeRouteArgs({required this.userId, this.key});

  final String userId;

  final _i17.Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{userId: $userId, key: $key}';
  }
}

/// generated route for
/// [_i10.MapPage]
class MapRoute extends _i11.PageRouteInfo<void> {
  const MapRoute() : super(MapRoute.name, path: 'map-page');

  static const String name = 'MapRoute';
}

/// generated route for
/// [_i11.EmptyRouterPage]
class CategoryRouter extends _i11.PageRouteInfo<void> {
  const CategoryRouter({List<_i11.PageRouteInfo>? children})
      : super(CategoryRouter.name, path: 'category', initialChildren: children);

  static const String name = 'CategoryRouter';
}

/// generated route for
/// [_i12.FavoritesPage]
class FavoritesRoute extends _i11.PageRouteInfo<void> {
  const FavoritesRoute() : super(FavoritesRoute.name, path: 'favorites-page');

  static const String name = 'FavoritesRoute';
}

/// generated route for
/// [_i11.EmptyRouterPage]
class ProfileRouter extends _i11.PageRouteInfo<void> {
  const ProfileRouter({List<_i11.PageRouteInfo>? children})
      : super(ProfileRouter.name, path: 'profile', initialChildren: children);

  static const String name = 'ProfileRouter';
}

/// generated route for
/// [_i13.CategoriesPage]
class CategoriesRoute extends _i11.PageRouteInfo<void> {
  const CategoriesRoute() : super(CategoriesRoute.name, path: '');

  static const String name = 'CategoriesRoute';
}

/// generated route for
/// [_i14.SelectedCategoryPage]
class SelectedCategoryRoute
    extends _i11.PageRouteInfo<SelectedCategoryRouteArgs> {
  SelectedCategoryRoute(
      {required List<_i18.Restaurant> restaurantList,
      required _i20.RestaurantCategory category,
      _i17.Key? key})
      : super(SelectedCategoryRoute.name,
            path: 'selected-category-page',
            args: SelectedCategoryRouteArgs(
                restaurantList: restaurantList, category: category, key: key));

  static const String name = 'SelectedCategoryRoute';
}

class SelectedCategoryRouteArgs {
  const SelectedCategoryRouteArgs(
      {required this.restaurantList, required this.category, this.key});

  final List<_i18.Restaurant> restaurantList;

  final _i20.RestaurantCategory category;

  final _i17.Key? key;

  @override
  String toString() {
    return 'SelectedCategoryRouteArgs{restaurantList: $restaurantList, category: $category, key: $key}';
  }
}

/// generated route for
/// [_i15.BestPlacesPage]
class BestPlacesRoute extends _i11.PageRouteInfo<BestPlacesRouteArgs> {
  BestPlacesRoute(
      {required List<_i18.Restaurant> bestPlacesList, _i17.Key? key})
      : super(BestPlacesRoute.name,
            path: 'best-places-page',
            args:
                BestPlacesRouteArgs(bestPlacesList: bestPlacesList, key: key));

  static const String name = 'BestPlacesRoute';
}

class BestPlacesRouteArgs {
  const BestPlacesRouteArgs({required this.bestPlacesList, this.key});

  final List<_i18.Restaurant> bestPlacesList;

  final _i17.Key? key;

  @override
  String toString() {
    return 'BestPlacesRouteArgs{bestPlacesList: $bestPlacesList, key: $key}';
  }
}

/// generated route for
/// [_i16.ProfilePage]
class ProfileRoute extends _i11.PageRouteInfo<void> {
  const ProfileRoute() : super(ProfileRoute.name, path: '');

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i16.ProfileSettingsCardPage]
class ProfileSettingsCardRoute
    extends _i11.PageRouteInfo<ProfileSettingsCardRouteArgs> {
  ProfileSettingsCardRoute(
      {required List<_i21.PaymentMethod> paymentCard,
      required String mainCard,
      _i17.Key? key})
      : super(ProfileSettingsCardRoute.name,
            path: 'profile-settings-card-page',
            args: ProfileSettingsCardRouteArgs(
                paymentCard: paymentCard, mainCard: mainCard, key: key));

  static const String name = 'ProfileSettingsCardRoute';
}

class ProfileSettingsCardRouteArgs {
  const ProfileSettingsCardRouteArgs(
      {required this.paymentCard, required this.mainCard, this.key});

  final List<_i21.PaymentMethod> paymentCard;

  final String mainCard;

  final _i17.Key? key;

  @override
  String toString() {
    return 'ProfileSettingsCardRouteArgs{paymentCard: $paymentCard, mainCard: $mainCard, key: $key}';
  }
}

/// generated route for
/// [_i16.ProfileSettingsPage]
class ProfileSettingsRoute
    extends _i11.PageRouteInfo<ProfileSettingsRouteArgs> {
  ProfileSettingsRoute({required _i22.CurrentUser userInfo, _i17.Key? key})
      : super(ProfileSettingsRoute.name,
            path: 'profile-settings-page',
            args: ProfileSettingsRouteArgs(userInfo: userInfo, key: key));

  static const String name = 'ProfileSettingsRoute';
}

class ProfileSettingsRouteArgs {
  const ProfileSettingsRouteArgs({required this.userInfo, this.key});

  final _i22.CurrentUser userInfo;

  final _i17.Key? key;

  @override
  String toString() {
    return 'ProfileSettingsRouteArgs{userInfo: $userInfo, key: $key}';
  }
}

/// generated route for
/// [_i16.SupportServicePage]
class SupportServiceRoute extends _i11.PageRouteInfo<void> {
  const SupportServiceRoute()
      : super(SupportServiceRoute.name, path: 'support-service-page');

  static const String name = 'SupportServiceRoute';
}

/// generated route for
/// [_i16.AboutApplicationPage]
class AboutApplicationRoute extends _i11.PageRouteInfo<void> {
  const AboutApplicationRoute()
      : super(AboutApplicationRoute.name, path: 'about-application-page');

  static const String name = 'AboutApplicationRoute';
}

/// generated route for
/// [_i16.ProfileBookingPage]
class ProfileBookingRoute extends _i11.PageRouteInfo<ProfileBookingRouteArgs> {
  ProfileBookingRoute({required List<_i23.Booking> bookings, _i17.Key? key})
      : super(ProfileBookingRoute.name,
            path: 'profile-booking-page',
            args: ProfileBookingRouteArgs(bookings: bookings, key: key));

  static const String name = 'ProfileBookingRoute';
}

class ProfileBookingRouteArgs {
  const ProfileBookingRouteArgs({required this.bookings, this.key});

  final List<_i23.Booking> bookings;

  final _i17.Key? key;

  @override
  String toString() {
    return 'ProfileBookingRouteArgs{bookings: $bookings, key: $key}';
  }
}

/// generated route for
/// [_i16.BookingDetailedPage]
class BookingDetailedRoute
    extends _i11.PageRouteInfo<BookingDetailedRouteArgs> {
  BookingDetailedRoute({required _i23.Booking booking, _i17.Key? key})
      : super(BookingDetailedRoute.name,
            path: 'booking-detailed-page',
            args: BookingDetailedRouteArgs(booking: booking, key: key));

  static const String name = 'BookingDetailedRoute';
}

class BookingDetailedRouteArgs {
  const BookingDetailedRouteArgs({required this.booking, this.key});

  final _i23.Booking booking;

  final _i17.Key? key;

  @override
  String toString() {
    return 'BookingDetailedRouteArgs{booking: $booking, key: $key}';
  }
}

/// generated route for
/// [_i16.AddNewCardPage]
class AddNewCardRoute extends _i11.PageRouteInfo<void> {
  const AddNewCardRoute()
      : super(AddNewCardRoute.name, path: 'add-new-card-page');

  static const String name = 'AddNewCardRoute';
}
