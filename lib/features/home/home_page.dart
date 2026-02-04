import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/glow_button.dart';
import '../../core/widgets/max_width.dart';
import '../../core/widgets/section_header.dart';
import '../../domain/models/portfolio_models.dart';
import 'bloc/portfolio_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: BlocBuilder<PortfolioBloc, PortfolioState>(
        builder: (context, state) {
          if (state.status == PortfolioStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryGreen),
            );
          }

          if (state.status == PortfolioStatus.failure) {
            return Center(
              child: Text(
                state.error ?? 'Failed to load data',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            );
          }

          final data = state.data;
          if (data == null) {
            return const SizedBox.shrink();
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                TopNavBar(socials: data.profile.socials),
                const SizedBox(height: 40),
                HeroSection(profile: data.profile),
                const SizedBox(height: 90),
                CaseStudiesSection(caseStudies: data.caseStudies),
                const SizedBox(height: 90),
              ],
            ),
          );
        },
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  final PortfolioProfile profile;

  const HeroSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MaxWidth(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 960;
          final textStyle = theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.mutedOnDark,
            height: 1.7,
          );

          final content = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.name,
                style: theme.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColors.textOnDark,
                ),
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Text(profile.intro, style: textStyle),
              ),
              const SizedBox(height: 24),
              GlowButton(
                label: "Let's get started",
                onPressed: () {},
              ),
              const SizedBox(height: 42),
              Text(
                'Worked with',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.mutedOnDark,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 18,
                runSpacing: 16,
                children: profile.workedWith
                    .map((logo) => PartnerLogoCard(logo: logo))
                    .toList(),
              ),
            ],
          );

          final image = HeroImage(assetPath: profile.heroImageUrl);

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
              content,
              const SizedBox(height: 32),
              Align(alignment: Alignment.center, child: image),
            ],
          );
        },
      ),
    );
  }
}

class TopNavBar extends StatelessWidget {
  final List<SocialLink> socials;

  const TopNavBar({super.key, required this.socials});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final navStyle = theme.textTheme.bodySmall?.copyWith(
      color: AppColors.mutedOnDark,
      letterSpacing: 1.1,
    );

    return MaxWidth(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.borderOnDark),
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 900;
            final items = [
              'Home',
              'Case Studies',
              'Testimonials',
              'Recent work',
              'Get In Touch',
            ];

            final menu = Wrap(
              spacing: 28,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: items
                  .map((label) => Text(label, style: navStyle))
                  .toList(),
            );

            final socialsRow = Row(
              mainAxisSize: MainAxisSize.min,
              children: socials
                  .map(
                    (s) => Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: _SocialChip(label: s.label),
                    ),
                  )
                  .toList(),
            );

            if (isWide) {
              return Row(
                children: [
                  Expanded(child: menu),
                  socialsRow,
                ],
              );
            }

            return Column(
              children: [
                menu,
                const SizedBox(height: 12),
                socialsRow,
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SocialChip extends StatelessWidget {
  final String label;

  const _SocialChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderOnDark),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.mutedOnDark,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class HeroImage extends StatelessWidget {
  final String assetPath;

  const HeroImage({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: ClipOval(
        child: Image.asset(
          assetPath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFF1A1A1A),
              child: const Icon(Icons.person, size: 120, color: Color(0xFF4A4A4A)),
            );
          },
        ),
      ),
    );
  }
}

class PartnerLogoCard extends StatelessWidget {
  final PartnerLogo logo;

  const PartnerLogoCard({super.key, required this.logo});

  @override
  Widget build(BuildContext context) {
    final isSvg = logo.assetPath.toLowerCase().endsWith('.svg');

    return Container(
      width: 150,
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.cardOnDark,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderOnDark),
      ),
      child: isSvg
          ? SvgPicture.asset(
              logo.assetPath,
              fit: BoxFit.contain,
              colorFilter: const ColorFilter.mode(
                Color(0xFF5B5B5B),
                BlendMode.srcIn,
              ),
              placeholderBuilder: (context) => _LogoFallback(name: logo.name),
            )
          : Image.asset(
              logo.assetPath,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.medium,
              errorBuilder: (context, error, stackTrace) => _LogoFallback(name: logo.name),
            ),
    );
  }
}

class CaseStudiesSection extends StatelessWidget {
  final List<CaseStudy> caseStudies;

  const CaseStudiesSection({super.key, required this.caseStudies});

  @override
  Widget build(BuildContext context) {
    return MaxWidth(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          const SectionHeader(
            title: 'Case Studies',
            subtitle:
                'Solving user & business problems since last 15+ years. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            dark: true,
          ),
          const SizedBox(height: 36),
          ...caseStudies.map((cs) => CaseStudyRow(caseStudy: cs)).toList(),
        ],
      ),
    );
  }
}

class CaseStudyRow extends StatelessWidget {
  final CaseStudy caseStudy;

  const CaseStudyRow({super.key, required this.caseStudy});

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
    final isEven = caseStudy.id.hashCode.isEven;
    final accent = _accentColor(caseStudy.accent);

    final imageCard = ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Image.asset(
        caseStudy.imageUrl,
        width: 520,
        height: 320,
        fit: BoxFit.cover,
      ),
    );

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
            caseStudy.tag,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: accent,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          caseStudy.title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textOnDark,
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 10),
        Text(
          caseStudy.summary,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.mutedOnDark,
                height: 1.6,
              ),
        ),
        const SizedBox(height: 18),
        GlowButton(label: 'View case study', color: accent, onPressed: () {}),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 26),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;
          if (!isWide) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imageCard,
                const SizedBox(height: 18),
                content,
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isEven) ...[
                Expanded(child: content),
                const SizedBox(width: 32),
                imageCard,
              ] else ...[
                imageCard,
                const SizedBox(width: 32),
                Expanded(child: content),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _LogoFallback extends StatelessWidget {
  final String name;

  const _LogoFallback({required this.name});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        name,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.mutedOnDark,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
