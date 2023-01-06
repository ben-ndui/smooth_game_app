import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_game_app/core/common/smooth_config.dart';
import 'package:smooth_game_app/core/controllers/smooth_theme_controller.dart';
import 'package:smooth_game_app/core/widgets/smooth_icon.dart';
import 'package:smooth_game_app/core/widgets/smooth_scaffold.dart';
import 'package:smooth_game_app/core/widgets/smooth_text.dart';

class SmoothDialog {
  final BuildContext context;
  final String? title;
  final Widget? body;
  final double? hMargin;
  final double? vMargin;
  final double? height;

  SmoothDialog(
      {this.title, required this.context, this.body, this.hMargin, this.vMargin, this.height});

  build() {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return SmoothScaffold(
          backgroundColor: Colors.black.withOpacity(0.8),
          body: Consumer<SmoothThemeController>(
            builder: (context, themeController, child) {
              return Container(
                color: Colors.transparent,
                height: height ?? 700.0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.router.pop();
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.zero,
                        width: SmoothConfig.screenWidth,
                        height: SmoothConfig.screenHeight,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: SmoothConfig.screenWidth,
                      margin: EdgeInsets.symmetric(
                        horizontal: hMargin ?? 25.0,
                        vertical: vMargin ?? 150.0,
                      ),
                      decoration: buildBoxDecoration(),
                      child: Column(
                        children: [
                          buildPopupHeader(themeController),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: ListView(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                children: [
                                  body ?? Container(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.5),
          spreadRadius: 0.0,
          blurRadius: 30.0,
        )
      ],
    );
  }

  Widget buildPopupHeader(SmoothThemeController themeController) {
    return Container(
      width: SmoothConfig.screenWidth,
      height: 70.0,
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: themeController.smoothColor.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmoothText(
            text: title ?? "",
            fontWeight: FontWeight.bold,
            textColor: Colors.black,
            fontSize: 18.0,
          ),
          SmoothIcon(
            icon: FontAwesomeIcons.xmark,
            onPressed: () => context.router.pop(),
          ),
        ],
      ),
    );
  }
}
