import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_game_app/core/controllers/smooth_theme_controller.dart';

class SmoothScaffold extends StatelessWidget {
  final Widget? drawer;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;

  const SmoothScaffold({
    Key? key,
    this.drawer,
    this.backgroundColor,
    this.appBar,
    this.body,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SmoothThemeController>(
      builder: (context, themeController, child) {
        return Scaffold(
          drawer: drawer,
          extendBodyBehindAppBar: true,
          backgroundColor: backgroundColor ??
              themeController.smoothColor
                  .themeData(themeController.darkTheme, context)
                  .backgroundColor,
          appBar: appBar,
          body: body,
          extendBody: true,
          floatingActionButton: floatingActionButton,
        );
      },
    );
  }
}
