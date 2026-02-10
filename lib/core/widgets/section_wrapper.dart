import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final isDark = _isDark(color);
    return BlocProvider(
      create: (_) => SectionThemeCubit(isDark),
      child: Container(
        width: double.infinity,
        color: color,
        padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
        child: child,
      ),
    );
  }

  bool _isDark(Color color) {
    return color.computeLuminance() < 0.5;
  }
}

class SectionThemeCubit extends Cubit<bool> {
  SectionThemeCubit(bool isDark) : super(isDark);

  bool get isDark => state;
}
