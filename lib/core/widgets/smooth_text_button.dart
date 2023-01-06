import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_game_app/core/common/smooth_config.dart';
import 'package:smooth_game_app/core/controllers/smooth_theme_controller.dart';
import 'package:smooth_game_app/core/widgets/smooth_text.dart';

class SmoothTextButton extends StatelessWidget {
  final String title;
  final double? vPadding;
  final double? hPadding;
  final Color? bgColor;
  final void Function()? action;

  const SmoothTextButton({
    Key? key,
    required this.title,
    this.action,
    this.hPadding,
    this.vPadding,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SmoothThemeController>(
      builder: (context, themeController, child) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SmoothConfig.screenWidth!),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.12), spreadRadius: 0.0, blurRadius: 10.0)
              ]),
          child: TextButton(
            onPressed: action,
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                vertical: vPadding ?? 0.0,
                horizontal: hPadding ?? 0.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(SmoothConfig.screenWidth!),
              ),
              backgroundColor: bgColor ??
                  themeController.smoothColor
                      .themeData(!themeController.darkTheme, context)
                      .primaryColor,
            ),
            child: SmoothText(
              text: title,
              fontWeight: FontWeight.bold,
              textColor: themeController.smoothColor
                  .themeData(themeController.darkTheme, context)
                  .primaryColor,
            ),
          ),
        );
      },
    );
  }
}
