import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toby_portfolio/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/glow_button.dart';
import '../../core/widgets/hover_zoom.dart';
import '../../core/widgets/max_width.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/section_wrapper.dart';
import '../../domain/models/portfolio_models.dart';
import '../../domain/repositories/portfolio_repository.dart';

class CaseStudyDetailsPage extends StatelessWidget {
  final String caseStudyId;

  const CaseStudyDetailsPage({super.key, required this.caseStudyId});

  Color _accentColor(String key) {
    switch (key) {
      case 'amber':
        return AppColors.accentAmber;
      case 'blue':
        return AppColors.accentBlue;
      case 'teal':
        return AppColors.accentTeal;
      default:
        return AppColors.primaryGreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    final repo = RepositoryProvider.of<PortfolioRepository>(
      context,
      listen: false,
    );

    return Scaffold(
      backgroundColor: AppColors.black,
      body: FutureBuilder<PortfolioData>(
        future: repo.getPortfolio(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryGreen),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.case_details_not_found,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            );
          }

          final data = snapshot.data!;
          final index = data.caseStudies.indexWhere((e) => e.id == caseStudyId);
          if (index == -1) {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.case_details_not_found,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            );
          }

          final study = data.caseStudies[index];
          final accent = _accentColor(study.accent);
          final nextStudy =
              data.caseStudies[(index + 1) % data.caseStudies.length];

          final sections = <SectionWrapper>[
            SectionWrapper(
              color: AppColors.black,
              topPadding: 32,
              bottomPadding: 60,
              child: _HeroSection(study: study, accent: accent),
            ),
            SectionWrapper(
              color: AppColors.black,
              topPadding: 50,
              bottomPadding: 50,
              child: _TechStackSection(study: study),
            ),
            SectionWrapper(
              color: AppColors.black,
              topPadding: 60,
              bottomPadding: 60,
              child: _OverviewSection(study: study),
            ),
            SectionWrapper(
              color: AppColors.black,
              topPadding: 50,
              bottomPadding: 50,
              child: _ApproachSection(steps: study.approachSteps),
            ),
            SectionWrapper(
              color: AppColors.black,
              topPadding: 50,
              bottomPadding: 50,
              child: _HighlightsSection(study: study),
            ),
            SectionWrapper(
              color: AppColors.black,
              topPadding: 0,
              bottomPadding: 50,
              child: _GallerySection(images: study.gallery),
            ),

            SectionWrapper(
              color: AppColors.black,
              topPadding: 50,
              bottomPadding: 50,
              child: _ChallengesSection(challenges: study.challenges),
            ),
            SectionWrapper(
              color: AppColors.black,
              topPadding: 50,
              bottomPadding: 60,
              child: _OutcomeSection(
                outcomes: study.outcomes,
                quote: study.quote,
              ),
            ),
            SectionWrapper(
              color: AppColors.black,
              topPadding: 60,
              bottomPadding: 90,
              child: _NextCaseStudySection(study: nextStudy),
            ),
          ];

          final themedSections = [
            for (var i = 0; i < sections.length; i++)
              SectionWrapper(
                color: i.isEven ? AppColors.black : AppColors.offWhite,
                topPadding: sections[i].topPadding,
                bottomPadding: sections[i].bottomPadding,
                child: sections[i].child,
              ),
          ];

          return SingleChildScrollView(child: Column(children: themedSections));
        },
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  final CaseStudy study;
  final Color accent;

  const _HeroSection({required this.study, required this.accent});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.watch<SectionThemeCubit>().isDark;
    final canLaunch = study.liveUrl != null && study.liveUrl!.trim().isNotEmpty;
    final heroMetrics = study.outcomes.isNotEmpty
        ? study.outcomes.take(3).toList()
        : const <CaseMetric>[];
    return MaxWidth(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 980;

          final content = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: accent.withOpacity(0.7)),
                ),
                child: Text(
                  study.tag,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: accent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                study.title,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: isDark
                      ? AppColors.textOnDark
                      : const Color(0xFF111111),
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                study.summary,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDark
                      ? AppColors.mutedOnDark
                      : const Color(0xFF4B4B4B),
                  height: 1.7,
                ),
              ),
              const SizedBox(height: 20),
              if (heroMetrics.isNotEmpty)
                Wrap(
                  spacing: 16,
                  runSpacing: 12,
                  children: heroMetrics
                      .map(
                        (metric) => _MetricCard(
                          label: metric.label,
                          value: metric.value,
                          dark: isDark,
                        ),
                      )
                      .toList(),
                ),
              const SizedBox(height: 22),
              GlowButton(
                label: l10n.case_details_view_live,
                color: canLaunch
                    ? AppColors.primaryGreen
                    : const Color(0xFF4A4A4A),
                onPressed: canLaunch
                    ? () {
                        final uri = Uri.parse(study.liveUrl!);
                        launchUrl(uri, mode: LaunchMode.externalApplication);
                      }
                    : null,
              ),
            ],
          );

          final image = ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: HoverZoom(
              child: Image.asset(
                study.imageUrl,
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
            children: [image, const SizedBox(height: 20), content],
          );
        },
      ),
    );
  }
}

class _OverviewSection extends StatelessWidget {
  final CaseStudy study;

  const _OverviewSection({required this.study});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.watch<SectionThemeCubit>().isDark;
    return MaxWidth(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          SectionHeader(
            title: l10n.case_details_project_overview_title,
            subtitle: l10n.case_details_project_overview_subtitle,
            dark: isDark,
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
                    title: l10n.case_details_problem_title,
                    body: study.problem,
                    dark: isDark,
                    width: isWide
                        ? (constraints.maxWidth - 24) / 2
                        : constraints.maxWidth,
                  ),
                  _OverviewTile(
                    title: l10n.case_details_goal_title,
                    body: study.goal,
                    dark: isDark,
                    width: isWide
                        ? (constraints.maxWidth - 24) / 2
                        : constraints.maxWidth,
                  ),
                  _OverviewTile(
                    title: l10n.case_details_role_title,
                    body: study.roleTimeline,
                    dark: isDark,
                    width: isWide
                        ? (constraints.maxWidth - 24) / 2
                        : constraints.maxWidth,
                  ),
                  _OverviewTile(
                    title: l10n.case_details_deliverables_title,
                    body: study.deliverables,
                    dark: isDark,
                    width: isWide
                        ? (constraints.maxWidth - 24) / 2
                        : constraints.maxWidth,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ApproachSection extends StatelessWidget {
  final List<CaseStep> steps;

  const _ApproachSection({required this.steps});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.watch<SectionThemeCubit>().isDark;
    return MaxWidth(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          SectionHeader(
            title: l10n.case_details_approach_title,
            subtitle: l10n.case_details_approach_subtitle,
            dark: isDark,
          ),
          const SizedBox(height: 24),
          for (var i = 0; i < steps.length; i++)
            _StepTile(
              index: '${i + 1}'.padLeft(2, '0'),
              title: steps[i].title,
              body: steps[i].body,
              dark: isDark,
            ),
        ],
      ),
    );
  }
}

class _HighlightsSection extends StatelessWidget {
  final CaseStudy study;

  const _HighlightsSection({required this.study});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.watch<SectionThemeCubit>().isDark;
    return MaxWidth(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          SectionHeader(
            title: l10n.case_details_highlights_title,
            subtitle: l10n.case_details_highlights_subtitle,
            dark: isDark,
          ),
          const SizedBox(height: 24),
          for (final item in study.highlights)
            _BulletItem(text: item, dark: isDark),
        ],
      ),
    );
  }
}

class _TechStackSection extends StatelessWidget {
  final CaseStudy study;

  const _TechStackSection({required this.study});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.watch<SectionThemeCubit>().isDark;
    return MaxWidth(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          SectionHeader(
            title: l10n.case_details_tech_stack_title,
            subtitle: l10n.case_details_tech_stack_subtitle,
            dark: isDark,
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: study.stack
                .map(
                  (item) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.cardOnDark : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isDark
                            ? AppColors.borderOnDark
                            : const Color(0xFFE2E2E2),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (item.svgStr.trim().isNotEmpty)
                          SvgPicture.string(item.svgStr, width: 18, height: 18)
                        else
                          Icon(
                            Icons.bolt,
                            size: 16,
                            color: isDark
                                ? Colors.white
                                : const Color(0xFF1A1A1A),
                          ),
                        const SizedBox(width: 8),
                        Text(
                          item.label,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: isDark
                                    ? AppColors.textOnDark
                                    : const Color(0xFF1A1A1A),
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
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

class _GallerySection extends StatelessWidget {
  final List<String> images;

  const _GallerySection({required this.images});

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return const SizedBox.shrink();
    final isDark = context.watch<SectionThemeCubit>().isDark;

    return MaxWidth(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          SectionHeader(
            title: 'Gallery',
            subtitle: 'Screens and details from the project.',
            dark: isDark,
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: HoverZoom(
                  child: Image.asset(
                    images[index],
                    width: 320,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemCount: images.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChallengesSection extends StatelessWidget {
  final List<CaseChallenge> challenges;

  const _ChallengesSection({required this.challenges});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.watch<SectionThemeCubit>().isDark;
    return MaxWidth(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          SectionHeader(
            title: l10n.case_details_challenges_title,
            subtitle: l10n.case_details_challenges_subtitle,
            dark: isDark,
          ),
          const SizedBox(height: 24),
          for (final challenge in challenges)
            _ChallengeTile(
              title: challenge.title,
              body: challenge.body,
              dark: isDark,
            ),
        ],
      ),
    );
  }
}

class _OutcomeSection extends StatelessWidget {
  final List<CaseMetric> outcomes;
  final String? quote;

  const _OutcomeSection({required this.outcomes, required this.quote});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.watch<SectionThemeCubit>().isDark;
    return MaxWidth(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          SectionHeader(
            title: l10n.case_details_outcome_title,
            subtitle: l10n.case_details_outcome_subtitle,
            dark: isDark,
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 18,
            runSpacing: 18,
            alignment: WrapAlignment.center,
            children: outcomes
                .map(
                  (metric) => _MetricCard(
                    label: metric.label,
                    value: metric.value,
                    dark: isDark,
                  ),
                )
                .toList(),
          ),
          if (quote != null && quote!.trim().isNotEmpty) ...[
            const SizedBox(height: 22),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
              decoration: BoxDecoration(
                color: isDark ? AppColors.cardOnDark : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark
                      ? AppColors.borderOnDark
                      : const Color(0xFFE2E2E2),
                ),
              ),
              child: Text(
                quote!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDark
                      ? AppColors.mutedOnDark
                      : const Color(0xFF4B4B4B),
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _NextCaseStudySection extends StatelessWidget {
  final CaseStudy study;

  const _NextCaseStudySection({required this.study});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.watch<SectionThemeCubit>().isDark;
    return MaxWidth(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          SectionHeader(
            title: l10n.case_details_next_title,
            subtitle: l10n.case_details_next_subtitle,
            dark: isDark,
          ),
          const SizedBox(height: 24),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: HoverZoom(
              child: Image.asset(
                study.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            study.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: isDark ? AppColors.textOnDark : const Color(0xFF111111),
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            study.summary,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isDark ? AppColors.mutedOnDark : const Color(0xFF4B4B4B),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),
          GlowButton(
            label: l10n.case_study_view,
            onPressed: () => context.go('/case-study/${study.id}'),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final bool dark;

  const _MetricCard({
    required this.label,
    required this.value,
    required this.dark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: dark ? AppColors.cardOnDark : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: dark ? AppColors.borderOnDark : const Color(0xFFE2E2E2),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: dark ? AppColors.textOnDark : const Color(0xFF111111),
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: dark ? AppColors.mutedOnDark : const Color(0xFF4B4B4B),
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
  final bool dark;

  const _OverviewTile({
    required this.title,
    required this.body,
    required this.width,
    required this.dark,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        decoration: BoxDecoration(
          color: dark ? AppColors.black : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: dark ? AppColors.borderOnDark : const Color(0xFFE2E2E2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: dark ? AppColors.textOnDark : const Color(0xFF111111),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              body,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: dark ? AppColors.mutedOnDark : const Color(0xFF4B4B4B),
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  final String index;
  final String title;
  final String body;
  final bool dark;

  const _StepTile({
    required this.index,
    required this.title,
    required this.body,
    required this.dark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: dark ? AppColors.cardOnDark : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: dark ? AppColors.borderOnDark : const Color(0xFFE2E2E2),
        ),
      ),
      child: Row(
        children: [
          Text(
            index,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: dark ? AppColors.textOnDark : const Color(0xFF111111),
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: dark
                        ? AppColors.textOnDark
                        : const Color(0xFF111111),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (body.trim().isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    body,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: dark
                          ? AppColors.mutedOnDark
                          : const Color(0xFF4B4B4B),
                      height: 1.6,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletItem extends StatelessWidget {
  final String text;
  final bool dark;

  const _BulletItem({required this.text, required this.dark});

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
            decoration: BoxDecoration(
              color: dark ? Colors.white : const Color(0xFF111111),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: dark ? AppColors.mutedOnDark : const Color(0xFF3B3B3B),
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChallengeTile extends StatelessWidget {
  final String title;
  final String body;
  final bool dark;

  const _ChallengeTile({
    required this.title,
    required this.body,
    required this.dark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: dark ? AppColors.black : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: dark ? AppColors.borderOnDark : const Color(0xFFE2E2E2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: dark ? AppColors.textOnDark : const Color(0xFF111111),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: dark ? AppColors.mutedOnDark : const Color(0xFF4B4B4B),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
