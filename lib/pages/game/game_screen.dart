import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_game_app/core/controllers/smooth_game_controller.dart';
import 'package:smooth_game_app/core/enums/game_enums.dart';
import 'package:smooth_game_app/core/widgets/smooth_custom_appbar.dart';
import 'package:smooth_game_app/core/widgets/smooth_list_view.dart';
import 'package:smooth_game_app/core/widgets/smooth_scaffold.dart';
import 'package:smooth_game_app/pages/game/smooth_gabo_screen.dart';
import 'package:smooth_game_app/pages/game/smooth_pyramid_screen.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmoothScaffold(
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Consumer<SmoothGameController>(
      builder: (context, smoothGameController, child) {
        return SmoothListView(
          children: [
            SmoothCustomAppBar(type: SmoothCustomAppBarType.game).build(),
            buildGameType(smoothGameController),
          ],
        );
      },
    );
  }

  Widget buildGameType(SmoothGameController smoothGameController) {
    switch (smoothGameController.gameType) {
      case SmoothGameType.gabo:
        return const SmoothGaboScreen();
      case SmoothGameType.pyramid:
        return const SmoothPyramidScreen();
      default:
        return const SmoothGaboScreen();
    }
  }
}
