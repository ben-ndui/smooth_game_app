import 'package:flutter/material.dart';

class SmoothListViewBuilder extends StatelessWidget {
  final int count;
  final Axis scrollDirection;
  final Widget Function(BuildContext, int) itemBuilder;

  const SmoothListViewBuilder({
    Key? key,
    required this.count,
    required this.itemBuilder,
    required this.scrollDirection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: scrollDirection,
      padding: EdgeInsets.zero,
      itemCount: count,
      itemBuilder: itemBuilder,
    );
  }
}
