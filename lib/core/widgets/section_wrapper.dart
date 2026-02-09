import 'package:flutter/material.dart';

class SectionWrapper extends StatelessWidget {
  final Widget child;
  final Color color;
  final double topPadding;
  final double bottomPadding;

  const SectionWrapper({
    super.key,
    required this.child,
    required this.color,
    this.topPadding = 0,
    this.bottomPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: color,
      padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
      child: child,
    );
  }
}
