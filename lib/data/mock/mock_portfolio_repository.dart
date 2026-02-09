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
      heroImageUrl: 'assets/images/profile_pic.png',
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
        problem: 'Legacy tools slowed ticket scanning and event reporting on-site.',
        goal: 'Deliver a fast, offline-capable mobile experience for staff and attendees.',
        roleTimeline: 'Full-stack mobile developer • 10 weeks • 3 teammates',
        deliverables: 'iOS/Android apps, admin dashboard, analytics, and CI/CD.',
        imageUrl: 'assets/images/projects_shots/explotel_mob_3.png',
        gallery: [
          'assets/images/projects_shots/explotel_mob_3.png',
          'assets/images/projects_shots/explotel_mob_3.png',
        ],
        accent: 'teal',
        approachSteps: [
          'Discovery: user interviews + flow mapping.',
          'Design: wireframes and UI kit for rapid iteration.',
          'Build: Flutter app + backend services.',
          'Launch: monitoring, analytics, and handoff.',
        ],
        highlights: [
          'Multi-tenant catalogs & pricing tiers',
          'Order lifecycle with delivery flows',
          'Analytics dashboards & exports',
        ],
        challenges: [
          CaseChallenge(
            title: 'Offline reliability',
            body: 'Added local caching with queued sync when connectivity returns.',
          ),
          CaseChallenge(
            title: 'Performance under load',
            body: 'Optimized API responses and reduced payload size by 35%.',
          ),
        ],
        stack: ['Flutter', 'Render', 'Vercel', 'AWS S3'],
        outcomes: [
          CaseMetric(label: 'Users', value: '120k+'),
          CaseMetric(label: 'Uptime', value: '99.9%'),
          CaseMetric(label: 'Revenue', value: '\$1.2M'),
        ],
        quote: '“Great collaboration and execution. The product is faster and more reliable.”',
        liveUrl:
            'https://play.google.com/store/apps/details?id=com.explotel.app',
      ),
      CaseStudy(
        id: 'motiboutik-mobile',
        tag: 'E-commerce',
        title: 'Work name here',
        summary:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.',
        problem: 'Mobile shoppers dropped off during checkout due to slow flows.',
        goal: 'Increase conversion with a streamlined, reliable mobile checkout.',
        roleTimeline: 'Mobile lead • 8 weeks • 2 teammates',
        deliverables: 'Mobile apps, order management, and push notifications.',
        imageUrl: 'assets/images/projects_shots/motiboutik_mob_2.png',
        gallery: [
          'assets/images/projects_shots/motiboutik_mob_2.png',
          'assets/images/projects_shots/motiboutik_mob_2.png',
        ],
        accent: 'blue',
        approachSteps: [
          'Audit funnel and identify drop-off points.',
          'Prototype new checkout and validate with users.',
          'Implement optimized flow and payment handling.',
          'Monitor conversion and iterate.',
        ],
        highlights: [
          'Offline-first mobile experience',
          'Push notifications & deep links',
          'Admin tooling for content lifecycle',
        ],
        challenges: [
          CaseChallenge(
            title: 'Payment reliability',
            body: 'Added retries and fallback providers to reduce failed payments.',
          ),
          CaseChallenge(
            title: 'App startup time',
            body: 'Lazy-loaded non-critical modules and optimized assets.',
          ),
        ],
        stack: ['Flutter', 'Firebase', 'Bloc', 'GoRouter'],
        outcomes: [
          CaseMetric(label: 'Conversion', value: '+18%'),
          CaseMetric(label: 'Crash rate', value: '-45%'),
          CaseMetric(label: 'Checkout time', value: '-32%'),
        ],
        quote: '“Checkout is faster and customers are finishing orders.”',
        liveUrl: null,
      ),
      CaseStudy(
        id: 'motiboutik-customer-web',
        tag: 'E-commerce',
        title: 'Motiboutik Custom Web Store',
        summary:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.',
        problem: 'The previous web store was rigid and hard to scale for campaigns.',
        goal: 'Build a flexible storefront with fast performance and integrations.',
        roleTimeline: 'Full-stack developer • 6 weeks • Solo',
        deliverables: 'Customer web store, CMS integration, analytics.',
        imageUrl: 'assets/images/projects_shots/motiboutik_customer_2.png',
        gallery: [
          'assets/images/projects_shots/motiboutik_customer_2.png',
          'assets/images/projects_shots/motiboutik_customer_2.png',
        ],
        accent: 'amber',
        approachSteps: [
          'Map requirements with marketing and ops.',
          'Design modular components for campaigns.',
          'Implement storefront and backend APIs.',
          'Launch with analytics and monitoring.',
        ],
        highlights: [
          'Subscription billing (Stripe) + webhooks',
          'Role-based dashboard & audit logs',
          'Performance-focused API design',
        ],
        challenges: [
          CaseChallenge(
            title: 'Catalog scale',
            body: 'Implemented server-side pagination and caching.',
          ),
        ],
        stack: ['Flutter', 'Node.js', 'TypeScript', 'PostgreSQL', 'Stripe'],
        outcomes: [
          CaseMetric(label: 'Page speed', value: '92+'),
          CaseMetric(label: 'Orders', value: '+25%'),
        ],
        quote: null,
        liveUrl: null,
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
