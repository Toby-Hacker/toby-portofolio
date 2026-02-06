import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:toby_portfolio/l10n/app_localizations.dart';

import '../../../core/theme/app_colors.dart';

import '../../../core/widgets/glow_button.dart';
import '../../../core/widgets/hover_zoom.dart';
import '../../../core/widgets/max_width.dart';
import '../../../core/widgets/section_header.dart';
import '../../../domain/models/portfolio_models.dart';

class RecentWorkSection extends StatelessWidget {
  final List<RecentWork> work;

  const RecentWorkSection({super.key, required this.work});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      color: AppColors.offWhite,
      padding: const EdgeInsets.symmetric(vertical: 90),
      child: MaxWidth(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: [
            SectionHeader(
              title: l10n.recent_work_title,
              subtitle: l10n.recent_work_subtitle,
              dark: false,
            ),
            const SizedBox(height: 36),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 900;
                final spacing = isWide ? 24.0 : 18.0;

                return Column(
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        _ArrowButton(icon: Icons.chevron_left),
                        const SizedBox(width: 10),
                        _ArrowButton(icon: Icons.chevron_right),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Wrap(
                      spacing: spacing,
                      runSpacing: spacing,
                      children: [
                        for (final item in work)
                          SizedBox(
                            width: isWide
                                ? (constraints.maxWidth - spacing) / 2
                                : constraints.maxWidth,
                            child: RecentWorkCard(work: item),
                          ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RecentWorkCard extends StatelessWidget {
  final RecentWork work;

  const RecentWorkCard({super.key, required this.work});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: HoverZoom(
            child: Image.asset(
              work.imageUrl,
              height: 260,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          work.title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: const Color(0xFF111111),
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          work.summary,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF4B4B4B),
                height: 1.6,
              ),
        ),
        const SizedBox(height: 14),
        GlowButton(
          label: AppLocalizations.of(context)!.recent_work_know_more,
          showArrow: true,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          onPressed: () => context.go('/work/${work.id}'),
        ),
      ],
    );
  }
}

class _ArrowButton extends StatelessWidget {
  final IconData icon;

  const _ArrowButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFDDDDDD)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, size: 20, color: const Color(0xFF333333)),
    );
  }
}
