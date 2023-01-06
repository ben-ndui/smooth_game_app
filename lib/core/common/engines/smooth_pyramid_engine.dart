import 'package:flutter/cupertino.dart';
import 'package:smooth_game_app/core/common/engines/engine.dart';
import 'package:smooth_game_app/core/widgets/smooth_text.dart';

class SmoothPyramidEngine implements SGEngine {
  @override
  int maxPlayer = 6;

  @override
  int getMaxPlayers() {
    return maxPlayer;
  }

  @override
  List<Widget> rules() {
    return [
      SmoothText(
        text: "Nombre de joueur maximum $maxPlayer",
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
      const SmoothText(text: "Jeu de 52 carte sans Joker"),
      const SmoothText(text: "1 - Rouge ou Noir"),
      const SmoothText(text: "2 - Plus ou Moins"),
      const SmoothText(text: "3 - Intérieur ou extérieur"),
      const SmoothText(text: "4 - Couleur"),
    ];
  }

  @override
  void setMaxPlayer(int value) {
    maxPlayer = value;
  }
}
