// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;

import '../presentation/pages/categories/categories_page.dart' as _i10;
import '../presentation/pages/favorites/favorites_page.dart' as _i11;
import '../presentation/pages/home/cafe/cafe_page.dart' as _i4;
import '../presentation/pages/home/cafe/menu_page.dart' as _i6;
import '../presentation/pages/home/cafe/time_select_page.dart' as _i7;
import '../presentation/pages/home/cart/cart_page.dart' as _i5;
import '../presentation/pages/home/home_page.dart' as _i8;
import '../presentation/pages/home/map/map_page.dart' as _i9;
import '../presentation/pages/login/enter_phone_page.dart' as _i1;
import '../presentation/pages/login/enter_pin_page.dart' as _i2;
import '../presentation/pages/login/information_page.dart' as _i3;
import '../presentation/pages/profile/profile_page.dart' as _i12;

class AppRouter extends _i13.RootStackRouter {
  AppRouter([_i14.GlobalKey<_i14.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    EnterPhoneRoute.name: (routeData) {
      return _i13.MaterialPageX<void>(
          routeData: routeData, child: const _i1.EnterPhonePage());
    },
    EnterPinRoute.name: (routeData) {
      final args = routeData.argsAs<EnterPinRouteArgs>();
      return _i13.MaterialPageX<void>(
          routeData: routeData,
          child: _i2.EnterPinPage(verId: args.verId, key: args.key));
    },
    InformationRoute.name: (routeData) {
      final args = routeData.argsAs<InformationRouteArgs>(
          orElse: () => const InformationRouteArgs());
      return _i13.MaterialPageX<void>(
          routeData: routeData, child: _i3.InformationPage(key: args.key));
    },
    CafeRoute.name: (routeData) {
      return _i13.MaterialPageX<void>(
          routeData: routeData, child: const _i4.CafePage());
    },
    CartRoute.name: (routeData) {
      return _i13.MaterialPageX<void>(
          routeData: routeData, child: const _i5.CartPage());
    },
    MenuRoute.name: (routeData) {
      return _i13.MaterialPageX<void>(
          routeData: routeData, child: const _i6.MenuPage());
    },
    TimeSelectRoute.name: (routeData) {
      return _i13.MaterialPageX<void>(
          routeData: routeData, child: const _i7.TimeSelectPage());
    },
    HomeRoute.name: (routeData) {
      final args = routeData.argsAs<HomeRouteArgs>();
      return _i13.MaterialPageX<void>(
          routeData: routeData,
          child: _i8.HomePage(userId: args.userId, key: args.key));
    },
    MapRoute.name: (routeData) {
      return _i13.MaterialPageX<void>(
          routeData: routeData, child: const _i9.MapPage());
    },
    CategoriesRoute.name: (routeData) {
      return _i13.MaterialPageX<void>(
          routeData: routeData, child: const _i10.CategoriesPage());
    },
    FavoritesRoute.name: (routeData) {
      return _i13.MaterialPageX<void>(
          routeData: routeData, child: const _i11.FavoritesPage());
    },
    ProfileRoute.name: (routeData) {
      return _i13.MaterialPageX<void>(
          routeData: routeData, child: const _i12.ProfilePage());
    }
  };

  @override
  List<_i13.RouteConfig> get routes => [
        _i13.RouteConfig(EnterPhoneRoute.name, path: '/'),
        _i13.RouteConfig(EnterPinRoute.name, path: '/enter-pin-page'),
        _i13.RouteConfig(InformationRoute.name, path: '/information-page'),
        _i13.RouteConfig(CafeRoute.name, path: '/cafe-page'),
        _i13.RouteConfig(CartRoute.name, path: '/cart-page'),
        _i13.RouteConfig(MenuRoute.name, path: '/menu-page'),
        _i13.RouteConfig(TimeSelectRoute.name, path: '/time-select-page'),
        _i13.RouteConfig(HomeRoute.name, path: '/home-page', children: [
          _i13.RouteConfig(MapRoute.name,
              path: 'map-page', parent: HomeRoute.name),
          _i13.RouteConfig(CategoriesRoute.name,
              path: 'categories-page', parent: HomeRoute.name),
          _i13.RouteConfig(FavoritesRoute.name,
              path: 'favorites-page', parent: HomeRoute.name),
          _i13.RouteConfig(ProfileRoute.name,
              path: 'profile-page', parent: HomeRoute.name)
        ])
      ];
}

/// generated route for
/// [_i1.EnterPhonePage]
class EnterPhoneRoute extends _i13.PageRouteInfo<void> {
  const EnterPhoneRoute() : super(EnterPhoneRoute.name, path: '/');

  static const String name = 'EnterPhoneRoute';
}

/// generated route for
/// [_i2.EnterPinPage]
class EnterPinRoute extends _i13.PageRouteInfo<EnterPinRouteArgs> {
  EnterPinRoute({required String verId, _i14.Key? key})
      : super(EnterPinRoute.name,
            path: '/enter-pin-page',
            args: EnterPinRouteArgs(verId: verId, key: key));

  static const String name = 'EnterPinRoute';
}

class EnterPinRouteArgs {
  const EnterPinRouteArgs({required this.verId, this.key});

  final String verId;

  final _i14.Key? key;

  @override
  String toString() {
    return 'EnterPinRouteArgs{verId: $verId, key: $key}';
  }
}

/// generated route for
/// [_i3.InformationPage]
class InformationRoute extends _i13.PageRouteInfo<InformationRouteArgs> {
  InformationRoute({_i14.Key? key})
      : super(InformationRoute.name,
            path: '/information-page', args: InformationRouteArgs(key: key));

  static const String name = 'InformationRoute';
}

class InformationRouteArgs {
  const InformationRouteArgs({this.key});

  final _i14.Key? key;

  @override
  String toString() {
    return 'InformationRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.CafePage]
class CafeRoute extends _i13.PageRouteInfo<void> {
  const CafeRoute() : super(CafeRoute.name, path: '/cafe-page');

  static const String name = 'CafeRoute';
}

/// generated route for
/// [_i5.CartPage]
class CartRoute extends _i13.PageRouteInfo<void> {
  const CartRoute() : super(CartRoute.name, path: '/cart-page');

  static const String name = 'CartRoute';
}

/// generated route for
/// [_i6.MenuPage]
class MenuRoute extends _i13.PageRouteInfo<void> {
  const MenuRoute() : super(MenuRoute.name, path: '/menu-page');

  static const String name = 'MenuRoute';
}

/// generated route for
/// [_i7.TimeSelectPage]
class TimeSelectRoute extends _i13.PageRouteInfo<void> {
  const TimeSelectRoute()
      : super(TimeSelectRoute.name, path: '/time-select-page');

  static const String name = 'TimeSelectRoute';
}

/// generated route for
/// [_i8.HomePage]
class HomeRoute extends _i13.PageRouteInfo<HomeRouteArgs> {
  HomeRoute(
      {required String userId,
      _i14.Key? key,
      List<_i13.PageRouteInfo>? children})
      : super(HomeRoute.name,
            path: '/home-page',
            args: HomeRouteArgs(userId: userId, key: key),
            initialChildren: children);

  static const String name = 'HomeRoute';
}

class HomeRouteArgs {
  const HomeRouteArgs({required this.userId, this.key});

  final String userId;

  final _i14.Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{userId: $userId, key: $key}';
  }
}

/// generated route for
/// [_i9.MapPage]
class MapRoute extends _i13.PageRouteInfo<void> {
  const MapRoute() : super(MapRoute.name, path: 'map-page');

  static const String name = 'MapRoute';
}

/// generated route for
/// [_i10.CategoriesPage]
class CategoriesRoute extends _i13.PageRouteInfo<void> {
  const CategoriesRoute()
      : super(CategoriesRoute.name, path: 'categories-page');

  static const String name = 'CategoriesRoute';
}

/// generated route for
/// [_i11.FavoritesPage]
class FavoritesRoute extends _i13.PageRouteInfo<void> {
  const FavoritesRoute() : super(FavoritesRoute.name, path: 'favorites-page');

  static const String name = 'FavoritesRoute';
}

/// generated route for
/// [_i12.ProfilePage]
class ProfileRoute extends _i13.PageRouteInfo<void> {
  const ProfileRoute() : super(ProfileRoute.name, path: 'profile-page');

  static const String name = 'ProfileRoute';
}
