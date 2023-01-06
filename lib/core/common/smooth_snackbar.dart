import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_game_app/core/common/smooth_config.dart';
import 'package:smooth_game_app/core/controllers/smooth_theme_controller.dart';
import 'package:smooth_game_app/core/widgets/smooth_text.dart';

enum SmoothSnackbarType {
  classic,
  alert,
  danger,
  success,
}

class SmoothSnackBar {
  final BuildContext context;
  final SmoothSnackbarType type;

  SmoothSnackBar({required this.context, this.type = SmoothSnackbarType.classic});

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> build(
      {String? content, TextAlign? align}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: getColor(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SmoothConfig.screenWidth!),
        ),
        content: SmoothText(
          text: content ?? "",
          textAlign: align,
        ),
      ),
    );
  }

  Color getColor() {
    final themeController = context.read<SmoothThemeController>();
    switch (type) {
      case SmoothSnackbarType.classic:
        return themeController.smoothColor
            .themeData(themeController.darkTheme, context)
            .backgroundColor;
      case SmoothSnackbarType.alert:
        return themeController.smoothColor.alertColor;
      case SmoothSnackbarType.danger:
        return themeController.smoothColor.danger;
      case SmoothSnackbarType.success:
        return themeController.smoothColor.success;
      default:
        return themeController.smoothColor
            .themeData(themeController.darkTheme, context)
            .backgroundColor;
    }
  }
}

//themeController.smoothColor.themeData(themeController.darkTheme, context).backgroundColor
