import 'dart:async';

import '../../domain/models/portfolio_models.dart';
import '../../domain/repositories/portfolio_repository.dart';

class MockPortfolioRepository implements PortfolioRepository {
  late final PortfolioData _data = _build();

  @override
  Future<PortfolioData> getPortfolio() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return _data;
  }

  @override
  Future<CaseStudy?> getCaseStudyById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    return _data.caseStudies.cast<CaseStudy?>().firstWhere(
          (e) => e!.id == id,
          orElse: () => null,
        );
  }

  @override
  Future<RecentWork?> getRecentWorkById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    return _data.recentWork.cast<RecentWork?>().firstWhere(
          (e) => e!.id == id,
          orElse: () => null,
        );
  }

  PortfolioData _build() {
    const profile = PortfolioProfile(
      name: 'Your Name Here',
      intro:
          'Intro text: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      heroImageUrl:
          'assets/images/hero.png',
      workedWith: [
        PartnerLogo(name: 'ClickUp', assetPath: 'assets/logos/clickup.svg'),
        PartnerLogo(name: 'Dropbox', assetPath: 'assets/logos/dropbox.svg'),
        PartnerLogo(name: 'Paychex', assetPath: 'assets/logos/paychex.svg'),
        PartnerLogo(name: 'elastic', assetPath: 'assets/logos/elastic.svg'),
        PartnerLogo(name: 'stripe', assetPath: 'assets/logos/stripe.svg'),
      ],
      socials: [
        SocialLink(label: 'in', url: 'https://www.linkedin.com/'),
        SocialLink(label: 'Be', url: 'https://www.behance.net/'),
        SocialLink(label: 'tw', url: 'https://twitter.com/'),
      ],
    );

    const caseStudies = <CaseStudy>[
      CaseStudy(
        id: 'fintech',
        tag: 'Fintech',
        title: 'Work name here',
        summary:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.',
        imageUrl:
            'assets/images/case_fintech.png',
        accent: 'amber',
        highlights: [
          'Subscription billing (Stripe) + webhooks',
          'Role-based dashboard & audit logs',
          'Performance-focused API design',
        ],
        stack: ['Flutter', 'Node.js', 'TypeScript', 'PostgreSQL', 'Stripe'],
      ),
      CaseStudy(
        id: 'edtech',
        tag: 'EdTech',
        title: 'Work name here',
        summary:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.',
        imageUrl:
            'assets/images/case_edtech.png',
        accent: 'blue',
        highlights: [
          'Offline-first mobile experience',
          'Push notifications & deep links',
          'Admin tooling for content lifecycle',
        ],
        stack: ['Flutter', 'Firebase', 'Bloc', 'GoRouter'],
      ),
      CaseStudy(
        id: 'pharma',
        tag: 'Pharma',
        title: 'Work name here',
        summary:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.',
        imageUrl:
            'assets/images/case_pharma.png',
        accent: 'teal',
        highlights: [
          'Multi-tenant catalogs & pricing tiers',
          'Order lifecycle with delivery flows',
          'Analytics dashboards & exports',
        ],
        stack: ['Flutter', 'Render', 'Vercel', 'AWS S3'],
      ),
    ];

    const testimonials = <Testimonial>[
      Testimonial(
        id: 't1',
        quote:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        clientName: 'Client Name',
        avatarUrl:
            'assets/images/avatar_1.png',
      ),
      Testimonial(
        id: 't2',
        quote:
            'Consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        clientName: 'Client Name',
        avatarUrl:
            'assets/images/avatar_2.png',
      ),
      Testimonial(
        id: 't3',
        quote:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        clientName: 'Client Name',
        avatarUrl:
            'assets/images/avatar_3.png',
      ),
      Testimonial(
        id: 't4',
        quote:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        clientName: 'Client Name',
        avatarUrl:
            'assets/images/avatar_4.png',
      ),
    ];

    const recentWork = <RecentWork>[
      RecentWork(
        id: 'rw1',
        title: 'Work name here',
        summary:
            'Labore et dolore magna aliqua. sed do eiusmod tempor incididunt ut labore et dolore magna.',
        imageUrl:
            'assets/images/recent_1.png',
        stack: ['Flutter', 'Bloc', 'GoRouter'],
      ),
      RecentWork(
        id: 'rw2',
        title: 'Work name here',
        summary:
            'Tempor incididunt ut labore et dolore magna aliqua. sed do eiusmod tempor incididunt ut.',
        imageUrl:
            'assets/images/recent_2.png',
        stack: ['Node.js', 'TypeORM', 'PostgreSQL'],
      ),
      RecentWork(
        id: 'rw3',
        title: 'Work name here',
        summary:
            'Labore et dolore magna aliqua. sed do eiusmod tempor incididunt ut labore et dolore magna.',
        imageUrl:
            'assets/images/recent_3.png',
        stack: ['Stripe', 'Webhooks', 'Billing'],
      ),
      RecentWork(
        id: 'rw4',
        title: 'Work name here',
        summary:
            'Tempor incididunt ut labore et dolore magna aliqua. sed do eiusmod tempor incididunt ut.',
        imageUrl:
            'assets/images/recent_4.png',
        stack: ['AI', 'Monitoring', 'Dashboard'],
      ),
    ];

    return const PortfolioData(
      profile: profile,
      caseStudies: caseStudies,
      testimonials: testimonials,
      recentWork: recentWork,
    );
  }
}
