import 'package:flutter/cupertino.dart';

abstract class SGEngine {
  int maxPlayer = 2;

  List<Widget> rules();
  int getMaxPlayers();

  void setMaxPlayer(int value);
}