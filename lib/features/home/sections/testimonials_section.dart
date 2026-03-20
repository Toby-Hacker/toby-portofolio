import 'package:flutter/material.dart';
import 'package:toby_portfolio/l10n/app_localizations.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/max_width.dart';
import '../../../core/widgets/section_header.dart';
import '../../../domain/models/portfolio_models.dart';

class TestimonialsSection extends StatelessWidget {
  final List<Testimonial> testimonials;

  const TestimonialsSection({super.key, required this.testimonials});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      color: AppColors.black,
      padding: const EdgeInsets.symmetric(vertical: 90),
      child: MaxWidth(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: [
            SectionHeader(
              title: l10n.testimonials_title,
              subtitle: l10n.testimonials_subtitle,
              dark: true,
            ),
            const SizedBox(height: 40),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 900;
                final crossAxisCount = isWide ? 2 : 1;
                final spacing = isWide ? 28.0 : 18.0;

                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: [
                    for (final t in testimonials)
                      SizedBox(
                        width: isWide
                            ? (constraints.maxWidth - spacing) / crossAxisCount
                            : constraints.maxWidth,
                        child: TestimonialCard(testimonial: t),
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

class TestimonialCard extends StatelessWidget {
  final Testimonial testimonial;

  const TestimonialCard({super.key, required this.testimonial});

  @override
  Widget build(BuildContext context) {
    final avatarUrl = testimonial.avatarUrl?.trim();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
      decoration: BoxDecoration(
        color: AppColors.cardOnDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderOnDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '“',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppColors.textOnDark,
                  fontWeight: FontWeight.w900,
                  height: 0.8,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            testimonial.quote,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.mutedOnDark,
                  height: 1.7,
                ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              if (avatarUrl != null && avatarUrl.isNotEmpty)
                ClipOval(
                  child: Image.asset(
                    avatarUrl,
                    width: 46,
                    height: 46,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _InitialsAvatar(name: testimonial.clientName);
                    },
                  ),
                )
              else
                _InitialsAvatar(name: testimonial.clientName),
              const SizedBox(width: 12),
              Text(
                testimonial.clientName,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textOnDark,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InitialsAvatar extends StatelessWidget {
  final String name;

  const _InitialsAvatar({required this.name});

  String _initials(String value) {
    final parts = value
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();

    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();

    return '${parts.first.substring(0, 1)}${parts.last.substring(0, 1)}'
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color(0xFF2A2A2A),
        shape: BoxShape.circle,
      ),
      child: Text(
        _initials(name),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }
}
