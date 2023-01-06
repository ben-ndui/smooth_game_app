import 'package:flutter/material.dart';

class SmoothSpacer extends StatelessWidget {
  final double? vertical;
  final double? horizontal;
  const SmoothSpacer({Key? key, this.vertical, this.horizontal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: horizontal ?? 0.0,
      height: vertical ?? 0.0,
    );
  }
}
