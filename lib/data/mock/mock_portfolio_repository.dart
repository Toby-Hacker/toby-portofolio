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
      name: 'Amzath Yehouessi (Toby)',
      intro:
          '''I’m Toby, a developer who builds mobile and web applications from idea to production.

I care about doing things properly — clean architecture, clear communication, and products that don’t fall apart after launch.''',
      heroImageUrl: 'assets/images/hero.png',
      workedWith: [
        PartnerLogo(name: 'Flutter', assetPath: 'assets/logos/flutter.png'),
        PartnerLogo(name: 'Firebase', assetPath: 'assets/logos/firebase.png'),
        PartnerLogo(name: 'Node.js', assetPath: 'assets/logos/nodejs.png'),
        PartnerLogo(name: 'Next.js', assetPath: 'assets/logos/nextjs.png'),
        PartnerLogo(name: 'Google', assetPath: 'assets/logos/google.png'),
        PartnerLogo(
          name: 'Amazon AWS',
          assetPath: 'assets/logos/amazon-aws.png',
        ),
        PartnerLogo(name: 'Stripe', assetPath: 'assets/logos/stripe.png'),
        PartnerLogo(name: 'ChatGPT', assetPath: 'assets/logos/chatgpt.png'),
      ],
      socials: [
        SocialLink(label: 'in', url: 'https://www.linkedin.com/'),
        SocialLink(label: 'Be', url: 'https://www.behance.net/'),
        SocialLink(label: 'tw', url: 'https://twitter.com/'),
      ],
    );

    const caseStudies = <CaseStudy>[
      CaseStudy(
        id: 'explotel-mobile',
        tag: 'Ticketing',
        title: 'Explotel Mobile App',
        summary:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.',
        imageUrl: 'assets/images/projects_shots/explotel_mob_3.png',
        accent: 'teal',
        highlights: [
          'Multi-tenant catalogs & pricing tiers',
          'Order lifecycle with delivery flows',
          'Analytics dashboards & exports',
        ],
        stack: ['Flutter', 'Render', 'Vercel', 'AWS S3'],
      ),
      CaseStudy(
        id: 'motiboutik-mobile',
        tag: 'E-commerce',
        title: 'Work name here',
        summary:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.',
        imageUrl: 'assets/images/projects_shots/motiboutik_mob_2.png',
        accent: 'blue',
        highlights: [
          'Offline-first mobile experience',
          'Push notifications & deep links',
          'Admin tooling for content lifecycle',
        ],
        stack: ['Flutter', 'Firebase', 'Bloc', 'GoRouter'],
      ),
      CaseStudy(
        id: 'motiboutik-customer-web',
        tag: 'E-commerce',
        title: 'Motiboutik Custom Web Store',
        summary:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.',
        imageUrl: 'assets/images/projects_shots/motiboutik_customer_2.png',
        accent: 'amber',
        highlights: [
          'Subscription billing (Stripe) + webhooks',
          'Role-based dashboard & audit logs',
          'Performance-focused API design',
        ],
        stack: ['Flutter', 'Node.js', 'TypeScript', 'PostgreSQL', 'Stripe'],
      ),
    ];

    const testimonials = <Testimonial>[
      Testimonial(
        id: 't1',
        quote:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        clientName: 'Client Name',
        avatarUrl: 'assets/images/avatar_1.png',
      ),
      Testimonial(
        id: 't2',
        quote:
            'Consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        clientName: 'Client Name',
        avatarUrl: 'assets/images/avatar_2.png',
      ),
      Testimonial(
        id: 't3',
        quote:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        clientName: 'Client Name',
        avatarUrl: 'assets/images/avatar_3.png',
      ),
      Testimonial(
        id: 't4',
        quote:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        clientName: 'Client Name',
        avatarUrl: 'assets/images/avatar_4.png',
      ),
    ];

    const recentWork = <RecentWork>[
      RecentWork(
        id: 'rw1',
        title: 'Work name here',
        summary:
            'Labore et dolore magna aliqua. sed do eiusmod tempor incididunt ut labore et dolore magna.',
        imageUrl: 'assets/images/recent_1.png',
        stack: ['Flutter', 'Bloc', 'GoRouter'],
      ),
      RecentWork(
        id: 'rw2',
        title: 'Work name here',
        summary:
            'Tempor incididunt ut labore et dolore magna aliqua. sed do eiusmod tempor incididunt ut.',
        imageUrl: 'assets/images/recent_2.png',
        stack: ['Node.js', 'TypeORM', 'PostgreSQL'],
      ),
      RecentWork(
        id: 'rw3',
        title: 'Work name here',
        summary:
            'Labore et dolore magna aliqua. sed do eiusmod tempor incididunt ut labore et dolore magna.',
        imageUrl: 'assets/images/recent_3.png',
        stack: ['Stripe', 'Webhooks', 'Billing'],
      ),
      RecentWork(
        id: 'rw4',
        title: 'Work name here',
        summary:
            'Tempor incididunt ut labore et dolore magna aliqua. sed do eiusmod tempor incididunt ut.',
        imageUrl: 'assets/images/recent_4.png',
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
