import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_game_app/core/controllers/smooth_theme_controller.dart';

class SmoothText extends StatelessWidget {
  final String text;
  final Color? textColor;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final FontStyle? style;
  final double? fontSize;
  final double? vPadding;
  final double? hPadding;

  const SmoothText({
    Key? key,
    required this.text,
    this.textColor,
    this.textAlign,
    this.fontWeight,
    this.fontSize,
    this.hPadding,
    this.vPadding,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SmoothThemeController>(
      builder: (context, themeController, child) {
        return FadeIn(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: vPadding ?? 8.0,
              horizontal: hPadding ?? 8.0,
            ),
            child: Text(
              text,
              textAlign: textAlign,
              style: TextStyle(
                fontStyle: style,
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: textColor ??
                    themeController.smoothColor
                        .themeData(!themeController.darkTheme, context)
                        .primaryColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
