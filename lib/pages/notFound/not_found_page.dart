import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_game_app/core/common/smooth_config.dart';
import 'package:smooth_game_app/core/widgets/smooth_container.dart';
import 'package:smooth_game_app/core/widgets/smooth_pop_route_btn.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmoothContainer(
      decoration: const BoxDecoration(color: Colors.white),
      width: SmoothConfig.screenWidth,
      height: SmoothConfig.screenHeight,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FadeIn(
              duration: const Duration(seconds: 1),
              delay: const Duration(milliseconds: 300),
              child: Lottie.asset('assets/json/not-found.json', width: 130.0),
            ),
          ),
          const SmoothPopRoutesBtn(),
        ],
      ),
    );
  }
}
