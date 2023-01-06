import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:smooth_game_app/core/common/smooth_config.dart';
import 'package:smooth_game_app/core/widgets/smooth_text.dart';

class SmoothPopRoutesBtn extends StatelessWidget {
  const SmoothPopRoutesBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildPopRouteButton(context);
  }

  Widget buildPopRouteButton(BuildContext context) {
    return FadeInRight(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 8.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                context.router.pop();
              },
              style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(SmoothConfig.screenWidth!)),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 0.0,
                  )),
              child: const SmoothText(
                fontWeight: FontWeight.bold,
                textColor: Colors.white,
                text: "Detour",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
