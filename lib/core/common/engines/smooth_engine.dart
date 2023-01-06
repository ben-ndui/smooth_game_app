import 'package:smooth_game_app/core/common/engines/engine.dart';
import 'package:smooth_game_app/core/common/engines/smooth_gabo_engine.dart';
import 'package:smooth_game_app/core/common/engines/smooth_pyramid_engine.dart';
import 'package:smooth_game_app/core/common/engines/unavailable_engine.dart';
import 'package:smooth_game_app/core/enums/game_enums.dart';

class SmoothEngine {
  SGEngine sgEngine = UnavailableEngine();

  int maxPlayer = 1;

  SmoothEngine();

  updateMaxPlayer(int val) {
    sgEngine.setMaxPlayer(val);
  }

  void initEngine({required SmoothGameType gameType}) {
    switch (gameType) {
      case SmoothGameType.gabo:
        sgEngine = SmoothGaboEngine();
        break;
      case SmoothGameType.pyramid:
        sgEngine = SmoothPyramidEngine();
        break;
    }
  }

  getMaxPlayer() {
    return sgEngine.getMaxPlayers();
  }

  void updateMaxVavue(int value) {
    maxPlayer = value;
  }
}
