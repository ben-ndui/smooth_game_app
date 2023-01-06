// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
import 'package:auto_route/auto_route.dart';
import 'package:smooth_game_app/pages/game/game_screen.dart';
import 'package:smooth_game_app/pages/games/create_game_screen.dart';
import 'package:smooth_game_app/pages/games/game_room_page.dart';
import 'package:smooth_game_app/pages/games/games_page.dart';
import 'package:smooth_game_app/pages/home/home_screen.dart';
import 'package:smooth_game_app/pages/home/parts/home_details.dart';
import 'package:smooth_game_app/pages/notFound/not_found_page.dart';
import 'package:smooth_game_app/pages/profile/profile_screen.dart';
import 'package:smooth_game_app/pages/redirection/login_screen.dart';
import 'package:smooth_game_app/pages/redirection/smooth_redirection.dart';
import 'package:smooth_game_app/pages/settings/settings.dart';
import 'package:smooth_game_app/pages/settings/super_admin_settings_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Pages,Route',
  routes: <AutoRoute>[
    CustomRoute(
        page: HomeScreen,
        name: 'Home',
        initial: true,
        path: '/smooth-games/home/',
        transitionsBuilder: TransitionsBuilders.zoomIn),
    CustomRoute(
        page: HomeDetailsScreen,
        name: 'HomeDetails',
        path: '/smooth-games/home-details/',
        transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute(
        page: GamesPage,
        name: 'AllGames',
        path: '/smooth-games/game/all-games/',
        transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute(
        page: GameScreen,
        name: 'Game',
        path: '/smooth-games/game/',
        transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute(
        page: GameRoomPage,
        name: 'GameRoom',
        path: '/smooth-games/game-room/',
        transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: CreateGameScreen,
        name: 'CreateGame',
        path: '/smooth-games/create-game/',
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        page: ProfileScreen,
        name: 'MyProfile',
        path: '/smooth-games/account/',
        transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: LoginScreen,
        name: 'SmoothLogin',
        path: '/smooth-games/login/',
        transitionsBuilder: TransitionsBuilders.slideTop),
    CustomRoute(
        page: SmoothRedirection,
        name: 'AuthRedirection',
        path: '/smooth-games/redirection/',
        transitionsBuilder: TransitionsBuilders.slideTop),
    CustomRoute(
        page: SettingsScreen,
        name: 'SmoothSettings',
        path: '/smooth-games/settings/',
        transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute(
        page: SmoothAdminSettings,
        name: 'SmoothAdminSettingsScreen',
        path: '/smooth-games/admin-settings/',
        transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: NotFoundPage,
        name: 'NotFound',
        path: '/smooth-games/not-found/',
        transitionsBuilder: TransitionsBuilders.slideBottom),
  ],
)
class $AppRouter {}
