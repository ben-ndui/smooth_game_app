import 'package:flutter/material.dart';
import 'package:smooth_game_app/core/common/smooth_config.dart';

class SmoothContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;
  final Decoration? decoration;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;

  const SmoothContainer({
    Key? key,
    this.child,
    this.decoration,
    this.margin,
    this.padding,
    this.width,
    this.height,
    this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      width: width ?? SmoothConfig.screenWidth,
      height: height,
      margin: margin,
      padding: padding,
      decoration: decoration ?? const BoxDecoration(),
      child: child,
    );
  }
}
