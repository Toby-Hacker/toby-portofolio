import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool dark;

  const SectionHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.dark = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.displaySmall?.copyWith(
      fontWeight: FontWeight.w900,
      color: dark ? Colors.white : const Color(0xFF111111),
    );
    final subStyle = theme.textTheme.bodyMedium?.copyWith(
      height: 1.6,
      color: dark ? const Color(0xFFB5B5B5) : const Color(0xFF6B6B6B),
    );

    return Column(
      children: [
        Text(title, style: titleStyle, textAlign: TextAlign.center),
        const SizedBox(height: 10),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Text(subtitle, style: subStyle, textAlign: TextAlign.center),
        ),
      ],
    );
  }
}
