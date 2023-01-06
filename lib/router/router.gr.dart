// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;

import '../pages/game/game_screen.dart' as _i4;
import '../pages/games/create_game_screen.dart' as _i6;
import '../pages/games/game_room_page.dart' as _i5;
import '../pages/games/games_page.dart' as _i3;
import '../pages/home/home_screen.dart' as _i1;
import '../pages/home/parts/home_details.dart' as _i2;
import '../pages/notFound/not_found_page.dart' as _i12;
import '../pages/profile/profile_screen.dart' as _i7;
import '../pages/redirection/login_screen.dart' as _i8;
import '../pages/redirection/smooth_redirection.dart' as _i9;
import '../pages/settings/settings.dart' as _i10;
import '../pages/settings/super_admin_settings_screen.dart' as _i11;

class AppRouter extends _i13.RootStackRouter {
  AppRouter([_i14.GlobalKey<_i14.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    Home.name: (routeData) {
      return _i13.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.HomeScreen(),
        transitionsBuilder: _i13.TransitionsBuilders.zoomIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    HomeDetails.name: (routeData) {
      return _i13.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeDetailsScreen(),
        transitionsBuilder: _i13.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AllGames.name: (routeData) {
      return _i13.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i3.GamesPage(),
        transitionsBuilder: _i13.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    Game.name: (routeData) {
      return _i13.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.GameScreen(),
        transitionsBuilder: _i13.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    GameRoom.name: (routeData) {
      return _i13.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.GameRoomPage(),
        transitionsBuilder: _i13.TransitionsBuilders.slideLeft,
        opaque: true,
        barrierDismissible: false,
      );
    },
    CreateGame.name: (routeData) {
      return _i13.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i6.CreateGameScreen(),
        transitionsBuilder: _i13.TransitionsBuilders.slideBottom,
        opaque: true,
        barrierDismissible: false,
      );
    },
    MyProfile.name: (routeData) {
      return _i13.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i7.ProfileScreen(),
        transitionsBuilder: _i13.TransitionsBuilders.slideLeft,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SmoothLogin.name: (routeData) {
      return _i13.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i8.LoginScreen(),
        transitionsBuilder: _i13.TransitionsBuilders.slideTop,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AuthRedirection.name: (routeData) {
      return _i13.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i9.SmoothRedirection(),
        transitionsBuilder: _i13.TransitionsBuilders.slideTop,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SmoothSettings.name: (routeData) {
      return _i13.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i10.SettingsScreen(),
        transitionsBuilder: _i13.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SmoothAdminSettingsScreen.name: (routeData) {
      return _i13.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i11.SmoothAdminSettings(),
        transitionsBuilder: _i13.TransitionsBuilders.slideLeft,
        opaque: true,
        barrierDismissible: false,
      );
    },
    NotFound.name: (routeData) {
      return _i13.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i12.NotFoundPage(),
        transitionsBuilder: _i13.TransitionsBuilders.slideBottom,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i13.RouteConfig> get routes => [
        _i13.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/smooth-games/home/',
          fullMatch: true,
        ),
        _i13.RouteConfig(
          Home.name,
          path: '/smooth-games/home/',
        ),
        _i13.RouteConfig(
          HomeDetails.name,
          path: '/smooth-games/home-details/',
        ),
        _i13.RouteConfig(
          AllGames.name,
          path: '/smooth-games/game/all-games/',
        ),
        _i13.RouteConfig(
          Game.name,
          path: '/smooth-games/game/',
        ),
        _i13.RouteConfig(
          GameRoom.name,
          path: '/smooth-games/game-room/',
        ),
        _i13.RouteConfig(
          CreateGame.name,
          path: '/smooth-games/create-game/',
        ),
        _i13.RouteConfig(
          MyProfile.name,
          path: '/smooth-games/account/',
        ),
        _i13.RouteConfig(
          SmoothLogin.name,
          path: '/smooth-games/login/',
        ),
        _i13.RouteConfig(
          AuthRedirection.name,
          path: '/smooth-games/redirection/',
        ),
        _i13.RouteConfig(
          SmoothSettings.name,
          path: '/smooth-games/settings/',
        ),
        _i13.RouteConfig(
          SmoothAdminSettingsScreen.name,
          path: '/smooth-games/admin-settings/',
        ),
        _i13.RouteConfig(
          NotFound.name,
          path: '/smooth-games/not-found/',
        ),
      ];
}

/// generated route for
/// [_i1.HomeScreen]
class Home extends _i13.PageRouteInfo<void> {
  const Home()
      : super(
          Home.name,
          path: '/smooth-games/home/',
        );

  static const String name = 'Home';
}

/// generated route for
/// [_i2.HomeDetailsScreen]
class HomeDetails extends _i13.PageRouteInfo<void> {
  const HomeDetails()
      : super(
          HomeDetails.name,
          path: '/smooth-games/home-details/',
        );

  static const String name = 'HomeDetails';
}

/// generated route for
/// [_i3.GamesPage]
class AllGames extends _i13.PageRouteInfo<void> {
  const AllGames()
      : super(
          AllGames.name,
          path: '/smooth-games/game/all-games/',
        );

  static const String name = 'AllGames';
}

/// generated route for
/// [_i4.GameScreen]
class Game extends _i13.PageRouteInfo<void> {
  const Game()
      : super(
          Game.name,
          path: '/smooth-games/game/',
        );

  static const String name = 'Game';
}

/// generated route for
/// [_i5.GameRoomPage]
class GameRoom extends _i13.PageRouteInfo<void> {
  const GameRoom()
      : super(
          GameRoom.name,
          path: '/smooth-games/game-room/',
        );

  static const String name = 'GameRoom';
}

/// generated route for
/// [_i6.CreateGameScreen]
class CreateGame extends _i13.PageRouteInfo<void> {
  const CreateGame()
      : super(
          CreateGame.name,
          path: '/smooth-games/create-game/',
        );

  static const String name = 'CreateGame';
}

/// generated route for
/// [_i7.ProfileScreen]
class MyProfile extends _i13.PageRouteInfo<void> {
  const MyProfile()
      : super(
          MyProfile.name,
          path: '/smooth-games/account/',
        );

  static const String name = 'MyProfile';
}

/// generated route for
/// [_i8.LoginScreen]
class SmoothLogin extends _i13.PageRouteInfo<void> {
  const SmoothLogin()
      : super(
          SmoothLogin.name,
          path: '/smooth-games/login/',
        );

  static const String name = 'SmoothLogin';
}

/// generated route for
/// [_i9.SmoothRedirection]
class AuthRedirection extends _i13.PageRouteInfo<void> {
  const AuthRedirection()
      : super(
          AuthRedirection.name,
          path: '/smooth-games/redirection/',
        );

  static const String name = 'AuthRedirection';
}

/// generated route for
/// [_i10.SettingsScreen]
class SmoothSettings extends _i13.PageRouteInfo<void> {
  const SmoothSettings()
      : super(
          SmoothSettings.name,
          path: '/smooth-games/settings/',
        );

  static const String name = 'SmoothSettings';
}

/// generated route for
/// [_i11.SmoothAdminSettings]
class SmoothAdminSettingsScreen extends _i13.PageRouteInfo<void> {
  const SmoothAdminSettingsScreen()
      : super(
          SmoothAdminSettingsScreen.name,
          path: '/smooth-games/admin-settings/',
        );

  static const String name = 'SmoothAdminSettingsScreen';
}

/// generated route for
/// [_i12.NotFoundPage]
class NotFound extends _i13.PageRouteInfo<void> {
  const NotFound()
      : super(
          NotFound.name,
          path: '/smooth-games/not-found/',
        );

  static const String name = 'NotFound';
}
