import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_game_app/core/common/smooth_config.dart';
import 'package:smooth_game_app/core/controllers/smooth_theme_controller.dart';

class SmoothIcon extends StatelessWidget {
  final IconData icon;
  final double? size;
  final double? padding;
  final Color? color;
  final void Function()? onPressed;
  final bool fillBackground;

  const SmoothIcon({
    Key? key,
    required this.icon,
    this.size,
    this.onPressed,
    this.color,
    this.padding,
    this.fillBackground = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SmoothThemeController>(
      builder: (context, themeController, child) {
        return GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.all(padding ?? 8.0),
            decoration: BoxDecoration(
              color: fillBackground
                  ? themeController.smoothColor
                      .themeData(!themeController.darkTheme, context)
                      .primaryColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(SmoothConfig.screenWidth!),
            ),
            child: FaIcon(
              icon,
              size: size ?? 18.0,
              color: color ??
                  themeController.smoothColor
                      .themeData(themeController.darkTheme, context)
                      .primaryColor,
            ),
          ),
        );
      },
    );
  }
}
