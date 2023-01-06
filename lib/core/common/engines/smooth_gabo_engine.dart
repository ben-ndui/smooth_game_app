import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_game_app/core/common/engines/engine.dart';
import 'package:smooth_game_app/core/widgets/smooth_text.dart';

class SmoothGaboEngine implements SGEngine {
  @override
  int maxPlayer = 4;

  @override
  int getMaxPlayers() {
    return maxPlayer;
  }

  @override
  List<Widget> rules() {
    return [
      buildText("Un jeu de 52 cartes (sans Joker)"),
      buildText("À partir de 2 joueurs"),
      buildText("Nombre de joueurs maximum $maxPlayer"),
      buildText("Totaliser 5 points ou moins de points que ses adversaires"),
      buildText("4 cartes, disposées en carré, faces cachées, devant chaque joueur"),
    ];
  }

  Widget buildText(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 15.0,
      ),
      child: SmoothText(
        text: text,
        textAlign: TextAlign.start,
        fontWeight: FontWeight.bold,
        textColor: Colors.black.withOpacity(0.7),
      ),
    );
  }

  @override
  void setMaxPlayer(int value) {
    maxPlayer = value;
  }
}
