import 'package:flutter/material.dart';
import 'package:smooth_game_app/core/common/smooth_config.dart';
import 'package:smooth_game_app/core/widgets/smooth_container.dart';

class SmoothListView extends StatelessWidget {
  final List<Widget> children;
  final double? height;

  const SmoothListView({Key? key, required this.children, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmoothContainer(
      height: height ?? SmoothConfig.screenHeight,
      decoration: const BoxDecoration(color: Colors.white),
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: children,
      ),
    );
  }
}
