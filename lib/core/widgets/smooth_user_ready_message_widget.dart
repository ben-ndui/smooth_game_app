import 'package:flutter/material.dart';
import 'package:smooth_game_app/core/common/smooth_config.dart';
import 'package:smooth_game_app/core/widgets/smooth_text.dart';
import 'package:smooth_game_app/core/widgets/smooth_user_card_widget.dart';

class SmoothUserReadyMessageWidget extends StatelessWidget {
  final bool visible;
  final bool showSpecimen;

  const SmoothUserReadyMessageWidget({Key? key, required this.visible, required this.showSpecimen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildUserReadyMessageWidget();
  }

  Widget buildUserReadyMessageWidget() {
    return Visibility(
      visible: visible,
      child: whichBody(),
    );
  }

  Widget whichBody() {
    switch (showSpecimen) {
      case true:
        return Stack(
          alignment: Alignment.center,
          children: [
            const SmoothUserCardWidget(),
            buildSpecimenPlaceHolder(),
          ],
        );
      case false:
        return Container();
      default:
        return Stack(
          alignment: Alignment.center,
          children: [
            const SmoothUserCardWidget(),
            buildSpecimenPlaceHolder(),
          ],
        );
    }
  }

  Widget buildSpecimenPlaceHolder() {
    return Container(
      alignment: Alignment.center,
      width: SmoothConfig.screenWidth,
      height: 60.0,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(SmoothConfig.screenWidth!),
      ),
      child: Transform.rotate(
        angle: 12.4,
        child: SmoothText(
          text: 'SPECIMEN'.toUpperCase(),
          fontWeight: FontWeight.bold,
          style: FontStyle.italic,
          textColor: Colors.black.withOpacity(0.5),
        ),
      ),
    );
  }
}
