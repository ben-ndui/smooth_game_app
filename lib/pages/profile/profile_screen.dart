import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_game_app/core/common/smooth_config.dart';
import 'package:smooth_game_app/core/common/smooth_loader.dart';
import 'package:smooth_game_app/core/common/smooth_tools.dart';
import 'package:smooth_game_app/core/controllers/smooth_auth_controller.dart';
import 'package:smooth_game_app/core/controllers/smooth_theme_controller.dart';
import 'package:smooth_game_app/core/widgets/smooth_column.dart';
import 'package:smooth_game_app/core/widgets/smooth_container.dart';
import 'package:smooth_game_app/core/widgets/smooth_custom_appbar.dart';
import 'package:smooth_game_app/core/widgets/smooth_icon.dart';
import 'package:smooth_game_app/core/widgets/smooth_list_view.dart';
import 'package:smooth_game_app/core/widgets/smooth_scaffold.dart';
import 'package:smooth_game_app/core/widgets/smooth_text.dart';
import 'package:smooth_game_app/core/widgets/smooth_text_button.dart';
import 'package:smooth_game_app/router/router.gr.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeController = context.read<SmoothThemeController>();

    return Consumer<SmoothAuthController>(
      builder: (context, authController, child) {
        if (authController.currentUser != null) {
          return SmoothScaffold(
            floatingActionButton: buildFloatingActionButton(authController, context),
            body: Stack(
              alignment: Alignment.center,
              children: [
                SmoothListView(
                  children: [
                    SmoothCustomAppBar(type: SmoothCustomAppBarType.profile).build(
                      title: "Bonjour ${authController.currentUser?.pseudo}",
                    ),
                    buildUserHeaderInfos(themeController, context, authController),
                  ],
                ),
                SmoothLoader(
                  visible: context.read<SmoothAuthController>().isLoading,
                )
              ],
            ),
          );
        } else {
          return SmoothScaffold(
            body: Stack(
              alignment: Alignment.center,
              children: [
                SmoothTools().buildBackground(path: "assets/images/pyramid.jpg"),
                Container(
                  padding: EdgeInsets.zero,
                  width: SmoothConfig.screenWidth,
                  height: SmoothConfig.screenHeight,
                  child: SmoothColumn(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SmoothTextButton(
                        title: "Me connecter",
                        hPadding: 25.0,
                        vPadding: 4.0,
                        action: () {
                          context.router.push(const AuthRedirection());
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildUserHeaderInfos(
    SmoothThemeController themeController,
    BuildContext context,
    SmoothAuthController authController,
  ) {
    return FadeIn(
      child: SmoothContainer(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.symmetric(
          vertical: 30.0,
          horizontal: 20.0,
        ),
        decoration: BoxDecoration(
          color: themeController.smoothColor
              .themeData(themeController.darkTheme, context)
              .primaryColor,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 0.0,
              blurRadius: 20.0,
            )
          ],
        ),
        child: Row(
          children: [
            AdvancedAvatar(
              size: 50.0,
              name: authController.currentUser!.pseudo,
              statusColor: Colors.green,
            ),
            SmoothColumn(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SmoothText(
                  text: "Pseudo",
                  fontWeight: FontWeight.bold,
                  vPadding: 0.0,
                  style: FontStyle.italic,
                ),
                SmoothText(
                  vPadding: 0.0,
                  text: authController.currentUser!.pseudo,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  FloatingActionButton buildFloatingActionButton(
    SmoothAuthController authController,
    BuildContext context,
  ) {
    final themeController = context.read<SmoothThemeController>();
    return FloatingActionButton(
      onPressed: () {
        authController.signOut(context);
      },
      backgroundColor: themeController.smoothColor.danger,
      child: const SmoothIcon(
        fillBackground: false,
        icon: FontAwesomeIcons.personWalking,
      ),
    );
  }
}
