import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_game_app/core/common/smooth_config.dart';
import 'package:smooth_game_app/core/widgets/smooth_column.dart';
import 'package:smooth_game_app/core/widgets/smooth_container.dart';
import 'package:smooth_game_app/core/widgets/smooth_text.dart';

class SmoothLoader extends StatelessWidget {
  final bool visible;

  const SmoothLoader({Key? key, this.visible = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: SmoothContainer(
        width: SmoothConfig.screenWidth,
        height: SmoothConfig.screenHeight,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SmoothColumn(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/json/loading.json', width: 150.0),
            const SmoothText(text: "Let's get it !"),
          ],
        ),
      ),
    );
  }
}
