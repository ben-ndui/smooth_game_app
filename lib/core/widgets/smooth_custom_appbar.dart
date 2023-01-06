import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_game_app/core/common/smooth_config.dart';
import 'package:smooth_game_app/core/common/smooth_handle_error.dart';
import 'package:smooth_game_app/core/controllers/smooth_game_controller.dart';
import 'package:smooth_game_app/core/controllers/smooth_theme_controller.dart';
import 'package:smooth_game_app/core/models/smooth_game.dart';
import 'package:smooth_game_app/core/services/smooth_game_service.dart';
import 'package:smooth_game_app/core/widgets/smooth_container.dart';
import 'package:smooth_game_app/core/widgets/smooth_icon.dart';
import 'package:smooth_game_app/core/widgets/smooth_text.dart';
import 'package:smooth_game_app/router/router.gr.dart';

enum SmoothCustomAppBarType {
  classic,
  settings,
  page,
  gameRoom,
  allGames,
  login,
  profile,
  game,
}

class SmoothCustomAppBar {
  final SmoothCustomAppBarType type;

  SmoothCustomAppBar({
    this.type = SmoothCustomAppBarType.classic,
  });

  Widget build({String? title}) {
    return Consumer<SmoothThemeController>(
      builder: (context, themeController, child) {
        return SmoothContainer(
          width: SmoothConfig.screenWidth,
          padding: const EdgeInsets.only(
            top: 50.0,
            left: 10.0,
            right: 10.0,
            bottom: 10.0,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: type == SmoothCustomAppBarType.login
                ? Colors.transparent
                : themeController.smoothColor.primary,
          ),
          child: getBody(title, context),
        );
      },
    );
  }

  Widget getBody(String? title, BuildContext context) {
    switch (type) {
      case SmoothCustomAppBarType.classic:
        return buildClassicBody(context, title);
      case SmoothCustomAppBarType.login:
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SmoothIcon(
              icon: FontAwesomeIcons.chevronLeft,
              onPressed: () => context.router.pop(),
            ),
            buildTitle(title, textAlign: TextAlign.center),
          ],
        );
      case SmoothCustomAppBarType.settings:
        return Row(
          children: [
            SmoothIcon(
              onPressed: () {
                context.router.pop();
              },
              icon: FontAwesomeIcons.chevronDown,
            ),
            buildTitle(title),
          ],
        );
      case SmoothCustomAppBarType.page:
        return Row(
          children: [
            SmoothIcon(
              onPressed: () {
                context.router.pop();
              },
              icon: FontAwesomeIcons.chevronDown,
            ),
            buildTitle(title),
          ],
        );
      case SmoothCustomAppBarType.gameRoom:
        final gameController = context.read<SmoothGameController>();
        return StreamBuilder<SmoothGame>(
            stream: SmoothGameService().getGameById(gameController.selectedGame!.gameId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              if (snapshot.hasError) {
                return SmoothHandleError.classicOne(
                    className: 'smooth_custom_appbar', line: 92, error: snapshot.error.toString());
              }

              final game = snapshot.data;

              return Row(
                children: [
                  gameController.isUserReady
                      ? Container()
                      : SmoothIcon(
                          onPressed: () {
                            gameController.iamReady(game!);
                            context.router.replace(const Home());
                          },
                          icon: FontAwesomeIcons.chevronDown,
                        ),
                  buildTitle(title),
                  SmoothIcon(
                    onPressed: () {
                      gameController.leaveGame(context, game!);
                      context.router.pop();
                    },
                    icon: FontAwesomeIcons.personWalking,
                  ),
                ],
              );
            });
      case SmoothCustomAppBarType.allGames:
        return Row(
          children: [
            SmoothIcon(
              onPressed: () {
                context.router.pop();
              },
              icon: FontAwesomeIcons.chevronDown,
            ),
            buildTitle(title),
          ],
        );
      case SmoothCustomAppBarType.profile:
        return Row(
          children: [
            SmoothIcon(
              onPressed: () {
                context.router.pop();
              },
              icon: FontAwesomeIcons.chevronLeft,
            ),
            buildTitle(title),
          ],
        );
      case SmoothCustomAppBarType.game:
        return Row();
      default:
        return Row(
          children: [
            SmoothIcon(
              onPressed: () {
                context.router.pop();
              },
              icon: FontAwesomeIcons.chevronDown,
            ),
            buildTitle(title),
          ],
        );
    }
  }

  Widget buildClassicBody(BuildContext context, String? title) {
    return Row(
      children: [
        buildTitle(title),
        GestureDetector(
          onTap: () {
            context.router.push(const AuthRedirection());
          },
          child: Container(
            width: 50.0,
            height: 50.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(
                SmoothConfig.screenWidth!,
              ),
            ),
            child: const FaIcon(
              FontAwesomeIcons.user,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTitle(String? title, {TextAlign? textAlign}) {
    return Expanded(
      child: SmoothText(
        text: title ?? "",
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
        textAlign: textAlign,
      ),
    );
  }
}
