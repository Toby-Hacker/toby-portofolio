import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class GlowButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color color;
  final EdgeInsetsGeometry padding;
  final bool showArrow;

  const GlowButton({
    super.key,
    required this.label,
    this.onPressed,
    this.color = AppColors.primaryGreen,
    this.padding = const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
    this.showArrow = true,
  });

  @override
  State<GlowButton> createState() => _GlowButtonState();
}

class _GlowButtonState extends State<GlowButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final glow = widget.color.withOpacity(_hover ? 0.55 : 0.35);

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: widget.onPressed == null ? SystemMouseCursors.basic : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: widget.padding,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: glow,
                blurRadius: _hover ? 26 : 20,
                spreadRadius: _hover ? 3 : 2,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
              ),
              if (widget.showArrow) ...[
                const SizedBox(width: 10),
                const Icon(Icons.chevron_right, color: Colors.white, size: 18),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
