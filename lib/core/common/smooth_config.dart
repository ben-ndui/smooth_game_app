import 'package:flutter/material.dart';

class SmoothConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  double? textSize;
  double? titleSize;
  double? spacer;

  double? get getTextSize => textSize;

  double? get getTitleSize => titleSize;

  double? get getSpacerSize => spacer;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
    initThemesSize();
  }

  void initThemesSize() {
    textSize = SmoothConfig.screenWidth! * 0.045;
    titleSize = SmoothConfig.screenWidth! * 0.055;
    spacer = SmoothConfig.screenWidth! * 0.025;
  }
}
