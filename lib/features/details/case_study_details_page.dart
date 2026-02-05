import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toby_portfolio/l10n/app_localizations.dart';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/glow_button.dart';
import '../../core/widgets/max_width.dart';
import '../../core/widgets/section_header.dart';
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
    final repo = RepositoryProvider.of<PortfolioRepository>(context, listen: false);

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
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            );
          }

          final data = snapshot.data!;
          final index = data.caseStudies.indexWhere((e) => e.id == caseStudyId);
          if (index == -1) {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.case_details_not_found,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            );
          }

          final study = data.caseStudies[index];
          final accent = _accentColor(study.accent);
          final nextStudy = data.caseStudies[(index + 1) % data.caseStudies.length];

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 32),
                _HeroSection(study: study, accent: accent),
                const SizedBox(height: 60),
                const _OverviewSection(),
                const SizedBox(height: 50),
                const _ApproachSection(),
                const SizedBox(height: 50),
                _HighlightsSection(study: study),
                const SizedBox(height: 50),
                _TechStackSection(study: study),
                const SizedBox(height: 50),
                const _ChallengesSection(),
                const SizedBox(height: 50),
                const _OutcomeSection(),
                const SizedBox(height: 60),
                _NextCaseStudySection(study: nextStudy),
                const SizedBox(height: 90),
              ],
            ),
          );
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
    return MaxWidth(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 980;

          final content = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                      color: AppColors.textOnDark,
                      fontWeight: FontWeight.w900,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                study.summary,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.mutedOnDark,
                      height: 1.7,
                    ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 16,
                runSpacing: 12,
                children: [
                  _MetricCard(label: l10n.case_details_metric_users_label, value: '120k+'),
                  _MetricCard(label: l10n.case_details_metric_uptime_label, value: '99.9%'),
                  _MetricCard(label: l10n.case_details_metric_revenue_label, value: '\$1.2M'),
                ],
              ),
              const SizedBox(height: 22),
              GlowButton(label: l10n.case_details_view_live, onPressed: () {}),
            ],
          );

          final image = ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              study.imageUrl,
              width: 520,
              height: 320,
              fit: BoxFit.cover,
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
              title: l10n.case_details_project_overview_title,
              subtitle: l10n.case_details_project_overview_subtitle,
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
                      title: l10n.case_details_problem_title,
                      body: l10n.case_details_problem_body,
                      width: isWide ? (constraints.maxWidth - 24) / 2 : constraints.maxWidth,
                    ),
                    _OverviewTile(
                      title: l10n.case_details_goal_title,
                      body: l10n.case_details_goal_body,
                      width: isWide ? (constraints.maxWidth - 24) / 2 : constraints.maxWidth,
                    ),
                    _OverviewTile(
                      title: l10n.case_details_role_title,
                      body: l10n.case_details_role_body,
                      width: isWide ? (constraints.maxWidth - 24) / 2 : constraints.maxWidth,
                    ),
                    _OverviewTile(
                      title: l10n.case_details_deliverables_title,
                      body: l10n.case_details_deliverables_body,
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

class _ApproachSection extends StatelessWidget {
  const _ApproachSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MaxWidth(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          SectionHeader(
            title: l10n.case_details_approach_title,
            subtitle: l10n.case_details_approach_subtitle,
            dark: true,
          ),
          const SizedBox(height: 24),
          _StepTile(index: '01', title: l10n.case_details_step_1_title, body: l10n.case_details_step_1_body),
          _StepTile(index: '02', title: l10n.case_details_step_2_title, body: l10n.case_details_step_2_body),
          _StepTile(index: '03', title: l10n.case_details_step_3_title, body: l10n.case_details_step_3_body),
          _StepTile(index: '04', title: l10n.case_details_step_4_title, body: l10n.case_details_step_4_body),
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
    return Container(
      width: double.infinity,
      color: AppColors.offWhite,
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: MaxWidth(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: [
            SectionHeader(
              title: l10n.case_details_highlights_title,
              subtitle: l10n.case_details_highlights_subtitle,
              dark: false,
            ),
            const SizedBox(height: 24),
            for (final item in study.highlights) _BulletItem(text: item),
          ],
        ),
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
    return MaxWidth(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          SectionHeader(
            title: l10n.case_details_tech_stack_title,
            subtitle: l10n.case_details_tech_stack_subtitle,
            dark: true,
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: study.stack
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

class _ChallengesSection extends StatelessWidget {
  const _ChallengesSection();

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
              title: l10n.case_details_challenges_title,
              subtitle: l10n.case_details_challenges_subtitle,
              dark: true,
            ),
            const SizedBox(height: 24),
            _ChallengeTile(
              title: l10n.case_details_challenge_1_title,
              body: l10n.case_details_challenge_1_body,
            ),
            _ChallengeTile(
              title: l10n.case_details_challenge_2_title,
              body: l10n.case_details_challenge_2_body,
            ),
          ],
        ),
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
            title: l10n.case_details_outcome_title,
            subtitle: l10n.case_details_outcome_subtitle,
            dark: true,
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 18,
            runSpacing: 18,
            children: [
              _MetricCard(label: l10n.case_details_metric_retention_label, value: '+22%'),
              _MetricCard(label: l10n.case_details_metric_processing_time_label, value: '-40%'),
              _MetricCard(label: l10n.case_details_metric_nps_label, value: '64'),
            ],
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
            decoration: BoxDecoration(
              color: AppColors.cardOnDark,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderOnDark),
            ),
            child: Text(
              l10n.case_details_quote,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.mutedOnDark,
                    height: 1.6,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
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
    return Container(
      width: double.infinity,
      color: AppColors.offWhite,
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: MaxWidth(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: [
            SectionHeader(
              title: l10n.case_details_next_title,
              subtitle: l10n.case_details_next_subtitle,
              dark: false,
            ),
            const SizedBox(height: 24),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                study.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              study.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: const Color(0xFF111111),
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              study.summary,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF4B4B4B),
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

class _StepTile extends StatelessWidget {
  final String index;
  final String title;
  final String body;

  const _StepTile({required this.index, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.cardOnDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderOnDark),
      ),
      child: Row(
        children: [
          Text(
            index,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textOnDark,
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
                        color: AppColors.textOnDark,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 6),
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
        ],
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

class _ChallengeTile extends StatelessWidget {
  final String title;
  final String body;

  const _ChallengeTile({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
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
    );
  }
}
