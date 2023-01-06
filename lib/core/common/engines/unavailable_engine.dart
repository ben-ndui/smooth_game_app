import 'package:flutter/cupertino.dart';
import 'package:smooth_game_app/core/common/engines/engine.dart';

class UnavailableEngine implements SGEngine {
  @override
  int maxPlayer = 2;

  @override
  int getMaxPlayers() {
    return maxPlayer;
  }

  @override
  List<Widget> rules() {
    return [];
  }

  @override
  void setMaxPlayer(int value) {
    // TODO: implement setMaxPlayer
  }
}
