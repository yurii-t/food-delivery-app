// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/material.dart' as _i15;

import '../presentation/pages/categories/categories_page.dart' as _i11;
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
import '../presentation/pages/profile/profile_page.dart' as _i13;

class AppRouter extends _i14.RootStackRouter {
  AppRouter([_i15.GlobalKey<_i15.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      return _i14.MaterialPageX<void>(
          routeData: routeData, child: const _i1.AuthPage());
    },
    EnterPhoneRoute.name: (routeData) {
      return _i14.MaterialPageX<void>(
          routeData: routeData, child: const _i2.EnterPhonePage());
    },
    EnterPinRoute.name: (routeData) {
      final args = routeData.argsAs<EnterPinRouteArgs>();
      return _i14.MaterialPageX<void>(
          routeData: routeData,
          child: _i3.EnterPinPage(
              verId: args.verId,
              isRegistration: args.isRegistration,
              phoneNumber: args.phoneNumber,
              key: args.key));
    },
    InformationRoute.name: (routeData) {
      final args = routeData.argsAs<InformationRouteArgs>(
          orElse: () => const InformationRouteArgs());
      return _i14.MaterialPageX<void>(
          routeData: routeData, child: _i4.InformationPage(key: args.key));
    },
    CafeRoute.name: (routeData) {
      return _i14.MaterialPageX<void>(
          routeData: routeData, child: const _i5.CafePage());
    },
    CartRoute.name: (routeData) {
      return _i14.MaterialPageX<void>(
          routeData: routeData, child: const _i6.CartPage());
    },
    MenuRoute.name: (routeData) {
      return _i14.MaterialPageX<void>(
          routeData: routeData, child: const _i7.MenuPage());
    },
    TimeSelectRoute.name: (routeData) {
      return _i14.MaterialPageX<void>(
          routeData: routeData, child: const _i8.TimeSelectPage());
    },
    HomeRoute.name: (routeData) {
      final args = routeData.argsAs<HomeRouteArgs>();
      return _i14.MaterialPageX<void>(
          routeData: routeData,
          child: _i9.HomePage(userId: args.userId, key: args.key));
    },
    MapRoute.name: (routeData) {
      return _i14.MaterialPageX<void>(
          routeData: routeData, child: const _i10.MapPage());
    },
    CategoriesRoute.name: (routeData) {
      return _i14.MaterialPageX<void>(
          routeData: routeData, child: const _i11.CategoriesPage());
    },
    FavoritesRoute.name: (routeData) {
      return _i14.MaterialPageX<void>(
          routeData: routeData, child: const _i12.FavoritesPage());
    },
    ProfileRoute.name: (routeData) {
      return _i14.MaterialPageX<void>(
          routeData: routeData, child: const _i13.ProfilePage());
    }
  };

  @override
  List<_i14.RouteConfig> get routes => [
        _i14.RouteConfig(AuthRoute.name, path: '/'),
        _i14.RouteConfig(EnterPhoneRoute.name, path: '/enter-phone-page'),
        _i14.RouteConfig(EnterPinRoute.name, path: '/enter-pin-page'),
        _i14.RouteConfig(InformationRoute.name, path: '/information-page'),
        _i14.RouteConfig(CafeRoute.name, path: '/cafe-page'),
        _i14.RouteConfig(CartRoute.name, path: '/cart-page'),
        _i14.RouteConfig(MenuRoute.name, path: '/menu-page'),
        _i14.RouteConfig(TimeSelectRoute.name, path: '/time-select-page'),
        _i14.RouteConfig(HomeRoute.name, path: '/home-page', children: [
          _i14.RouteConfig(MapRoute.name,
              path: 'map-page', parent: HomeRoute.name),
          _i14.RouteConfig(CategoriesRoute.name,
              path: 'categories-page', parent: HomeRoute.name),
          _i14.RouteConfig(FavoritesRoute.name,
              path: 'favorites-page', parent: HomeRoute.name),
          _i14.RouteConfig(ProfileRoute.name,
              path: 'profile-page', parent: HomeRoute.name)
        ])
      ];
}

/// generated route for
/// [_i1.AuthPage]
class AuthRoute extends _i14.PageRouteInfo<void> {
  const AuthRoute() : super(AuthRoute.name, path: '/');

  static const String name = 'AuthRoute';
}

/// generated route for
/// [_i2.EnterPhonePage]
class EnterPhoneRoute extends _i14.PageRouteInfo<void> {
  const EnterPhoneRoute()
      : super(EnterPhoneRoute.name, path: '/enter-phone-page');

  static const String name = 'EnterPhoneRoute';
}

/// generated route for
/// [_i3.EnterPinPage]
class EnterPinRoute extends _i14.PageRouteInfo<EnterPinRouteArgs> {
  EnterPinRoute(
      {required String verId,
      required bool isRegistration,
      required String phoneNumber,
      _i15.Key? key})
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

  final _i15.Key? key;

  @override
  String toString() {
    return 'EnterPinRouteArgs{verId: $verId, isRegistration: $isRegistration, phoneNumber: $phoneNumber, key: $key}';
  }
}

/// generated route for
/// [_i4.InformationPage]
class InformationRoute extends _i14.PageRouteInfo<InformationRouteArgs> {
  InformationRoute({_i15.Key? key})
      : super(InformationRoute.name,
            path: '/information-page', args: InformationRouteArgs(key: key));

  static const String name = 'InformationRoute';
}

class InformationRouteArgs {
  const InformationRouteArgs({this.key});

  final _i15.Key? key;

  @override
  String toString() {
    return 'InformationRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.CafePage]
class CafeRoute extends _i14.PageRouteInfo<void> {
  const CafeRoute() : super(CafeRoute.name, path: '/cafe-page');

  static const String name = 'CafeRoute';
}

/// generated route for
/// [_i6.CartPage]
class CartRoute extends _i14.PageRouteInfo<void> {
  const CartRoute() : super(CartRoute.name, path: '/cart-page');

  static const String name = 'CartRoute';
}

/// generated route for
/// [_i7.MenuPage]
class MenuRoute extends _i14.PageRouteInfo<void> {
  const MenuRoute() : super(MenuRoute.name, path: '/menu-page');

  static const String name = 'MenuRoute';
}

/// generated route for
/// [_i8.TimeSelectPage]
class TimeSelectRoute extends _i14.PageRouteInfo<void> {
  const TimeSelectRoute()
      : super(TimeSelectRoute.name, path: '/time-select-page');

  static const String name = 'TimeSelectRoute';
}

/// generated route for
/// [_i9.HomePage]
class HomeRoute extends _i14.PageRouteInfo<HomeRouteArgs> {
  HomeRoute(
      {required String userId,
      _i15.Key? key,
      List<_i14.PageRouteInfo>? children})
      : super(HomeRoute.name,
            path: '/home-page',
            args: HomeRouteArgs(userId: userId, key: key),
            initialChildren: children);

  static const String name = 'HomeRoute';
}

class HomeRouteArgs {
  const HomeRouteArgs({required this.userId, this.key});

  final String userId;

  final _i15.Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{userId: $userId, key: $key}';
  }
}

/// generated route for
/// [_i10.MapPage]
class MapRoute extends _i14.PageRouteInfo<void> {
  const MapRoute() : super(MapRoute.name, path: 'map-page');

  static const String name = 'MapRoute';
}

/// generated route for
/// [_i11.CategoriesPage]
class CategoriesRoute extends _i14.PageRouteInfo<void> {
  const CategoriesRoute()
      : super(CategoriesRoute.name, path: 'categories-page');

  static const String name = 'CategoriesRoute';
}

/// generated route for
/// [_i12.FavoritesPage]
class FavoritesRoute extends _i14.PageRouteInfo<void> {
  const FavoritesRoute() : super(FavoritesRoute.name, path: 'favorites-page');

  static const String name = 'FavoritesRoute';
}

/// generated route for
/// [_i13.ProfilePage]
class ProfileRoute extends _i14.PageRouteInfo<void> {
  const ProfileRoute() : super(ProfileRoute.name, path: 'profile-page');

  static const String name = 'ProfileRoute';
}
