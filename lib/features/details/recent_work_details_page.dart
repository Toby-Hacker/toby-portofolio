import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toby_portfolio/l10n/app_localizations.dart';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/glow_button.dart';
import '../../core/widgets/hover_zoom.dart';
import '../../core/widgets/max_width.dart';
import '../../core/widgets/section_header.dart';
import '../../domain/models/portfolio_models.dart';
import '../../domain/repositories/portfolio_repository.dart';

class RecentWorkDetailsPage extends StatelessWidget {
  final String workId;

  const RecentWorkDetailsPage({super.key, required this.workId});

  @override
  Widget build(BuildContext context) {
    final repo = RepositoryProvider.of<PortfolioRepository>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.black,
      body: FutureBuilder<RecentWork?>(
        future: repo.getRecentWorkById(workId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryGreen),
            );
          }

          final work = snapshot.data;
          if (work == null) {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.recent_details_not_found,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 32),
                _HeroSection(work: work),
                const SizedBox(height: 60),
                const _OverviewSection(),
                const SizedBox(height: 50),
                _HighlightsSection(work: work),
                const SizedBox(height: 50),
                _TechStackSection(work: work),
                const SizedBox(height: 50),
                const _OutcomeSection(),
                const SizedBox(height: 80),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  final RecentWork work;

  const _HeroSection({required this.work});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MaxWidth(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 980;

          final content = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                work.title,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppColors.textOnDark,
                      fontWeight: FontWeight.w900,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                work.summary,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.mutedOnDark,
                      height: 1.7,
                    ),
              ),
              const SizedBox(height: 20),
              GlowButton(label: l10n.recent_details_visit_project, onPressed: () {}),
            ],
          );

          final image = ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: HoverZoom(
              child: Image.asset(
                work.imageUrl,
                width: 520,
                height: 320,
                fit: BoxFit.cover,
              ),
            ),
          );

          if (isWide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: content),
                const SizedBox(width: 40),
                image,
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              image,
              const SizedBox(height: 20),
              content,
            ],
          );
        },
      ),
    );
  }
}

class _OverviewSection extends StatelessWidget {
  const _OverviewSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      color: AppColors.cardOnDark,
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: MaxWidth(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: [
            SectionHeader(
              title: l10n.recent_details_project_overview_title,
              subtitle: l10n.recent_details_project_overview_subtitle,
              dark: true,
            ),
            const SizedBox(height: 28),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 900;
                return Wrap(
                  spacing: 24,
                  runSpacing: 18,
                  children: [
                    _OverviewTile(
                      title: l10n.recent_details_scope_title,
                      body: l10n.recent_details_scope_body,
                      width: isWide ? (constraints.maxWidth - 24) / 2 : constraints.maxWidth,
                    ),
                    _OverviewTile(
                      title: l10n.recent_details_role_title,
                      body: l10n.recent_details_role_body,
                      width: isWide ? (constraints.maxWidth - 24) / 2 : constraints.maxWidth,
                    ),
                    _OverviewTile(
                      title: l10n.recent_details_timeline_title,
                      body: l10n.recent_details_timeline_body,
                      width: isWide ? (constraints.maxWidth - 24) / 2 : constraints.maxWidth,
                    ),
                    _OverviewTile(
                      title: l10n.recent_details_deliverables_title,
                      body: l10n.recent_details_deliverables_body,
                      width: isWide ? (constraints.maxWidth - 24) / 2 : constraints.maxWidth,
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

class _HighlightsSection extends StatelessWidget {
  final RecentWork work;

  const _HighlightsSection({required this.work});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      color: AppColors.offWhite,
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: MaxWidth(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: [
            SectionHeader(
              title: l10n.recent_details_highlights_title,
              subtitle: l10n.recent_details_highlights_subtitle,
              dark: false,
            ),
            const SizedBox(height: 24),
            _BulletItem(text: l10n.recent_details_highlight_1),
            _BulletItem(text: l10n.recent_details_highlight_2),
            _BulletItem(text: l10n.recent_details_highlight_3),
          ],
        ),
      ),
    );
  }
}

class _TechStackSection extends StatelessWidget {
  final RecentWork work;

  const _TechStackSection({required this.work});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MaxWidth(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          SectionHeader(
            title: l10n.recent_details_tech_stack_title,
            subtitle: l10n.recent_details_tech_stack_subtitle,
            dark: true,
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: work.stack
                .map(
                  (item) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.cardOnDark,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.borderOnDark),
                    ),
                    child: Text(
                      item,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textOnDark,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _OutcomeSection extends StatelessWidget {
  const _OutcomeSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MaxWidth(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          SectionHeader(
            title: l10n.recent_details_outcome_title,
            subtitle: l10n.recent_details_outcome_subtitle,
            dark: true,
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 18,
            runSpacing: 18,
            children: [
              _MetricCard(label: l10n.recent_details_metric_retention_label, value: '+18%'),
              _MetricCard(label: l10n.recent_details_metric_latency_label, value: '-30%'),
              _MetricCard(label: l10n.recent_details_metric_crash_rate_label, value: '-45%'),
            ],
          ),
          const SizedBox(height: 22),
          GlowButton(
            label: l10n.recent_details_back_home,
            onPressed: () => context.go('/'),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;

  const _MetricCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardOnDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderOnDark),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textOnDark,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.mutedOnDark,
                ),
          ),
        ],
      ),
    );
  }
}

class _OverviewTile extends StatelessWidget {
  final String title;
  final String body;
  final double width;

  const _OverviewTile({required this.title, required this.body, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderOnDark),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textOnDark,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              body,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.mutedOnDark,
                    height: 1.6,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BulletItem extends StatelessWidget {
  final String text;

  const _BulletItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(right: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF111111),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF3B3B3B),
                    height: 1.6,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
