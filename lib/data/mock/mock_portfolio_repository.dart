import 'dart:async';

import '../../core/constants/stack_icon.dart';
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
        problem:
            'Legacy tools slowed ticket scanning and event reporting on-site.',
        goal:
            'Deliver a fast, offline-capable mobile experience for staff and attendees.',
        roleTimeline: 'Full-stack mobile developer • 10 weeks • 3 teammates',
        deliverables:
            'iOS/Android apps, admin dashboard, analytics, and CI/CD.',
        imageUrl: 'assets/images/projects_shots/explotel_mob_3.png',
        gallery: [
          'assets/images/projects_shots/explotel_mob_3.png',
          'assets/images/projects_shots/explotel_mob_3.png',
        ],
        accent: 'teal',
        approachSteps: [
          CaseStep(title: 'Discovery', body: 'User interviews + flow mapping.'),
          CaseStep(
            title: 'Design',
            body: 'Wireframes and UI kit for rapid iteration.',
          ),
          CaseStep(title: 'Build', body: 'Flutter app + backend services.'),
          CaseStep(
            title: 'Launch',
            body: 'Monitoring, analytics, and handoff.',
          ),
        ],
        highlights: [
          'Multi-tenant catalogs & pricing tiers',
          'Order lifecycle with delivery flows',
          'Analytics dashboards & exports',
        ],
        challenges: [
          CaseChallenge(
            title: 'Offline reliability',
            body:
                'Added local caching with queued sync when connectivity returns.',
          ),
          CaseChallenge(
            title: 'Performance under load',
            body: 'Optimized API responses and reduced payload size by 35%.',
          ),
        ],
        stack: [
          StackIcon.flutter,
          StackIcon.nodejs,
          StackIcon.aws,
          StackIcon.postgresql,
        ],
        outcomes: [
          CaseMetric(label: 'Users', value: '120k+'),
          CaseMetric(label: 'Uptime', value: '99.9%'),
          CaseMetric(label: 'Revenue', value: '\$1.2M'),
        ],
        quote:
            '“Great collaboration and execution. The product is faster and more reliable.”',
        liveUrl:
            'https://play.google.com/store/apps/details?id=com.explotel.app',
      ),
      CaseStudy(
        id: 'motiboutik',
        tag: 'Client Project • Upwork',
        title: 'Motiboutik — Seller-centric E-commerce Platform',
        summary:
            'A custom multi-tenant e-commerce platform built for an Upwork client, enabling sellers to create online stores, manage catalogs, orders, payments, and deliveries from a single system.',
        problem:
            'The client needed a solution tailored to local sellers who relied on WhatsApp and social media, with no structured way to manage catalogs, track orders, coordinate deliveries, or scale operations. Existing platforms were either too complex, too expensive, or poorly adapted to local workflows.',
        goal:
            'Deliver a production-ready platform aligned with the client’s business model, allowing sellers to launch stores quickly while centralizing sales, payments, subscriptions, and delivery management in a scalable system.',
        roleTimeline:
            'Lead Full-Stack Developer (Freelance, Upwork) • Multi-month engagement • Solo developer',
        deliverables:
            'Seller mobile application, customer storefront (web), backend API, database schema, subscription & billing system, delivery management module, and admin configuration tools.',
        imageUrl: 'assets/images/projects_shots/motiboutik_mob_2.png',
        gallery: [
          'assets/case_studies/motiboutik/seller_dashboard.png',
          'assets/case_studies/motiboutik/orders.png',
          'assets/case_studies/motiboutik/storefront.png',
          'assets/case_studies/motiboutik/delivery_tracking.png',
        ],
        accent: 'amber',
        approachSteps: [
          CaseStep(
            title: 'Discovery & alignment',
            body:
                'Worked closely with the client to understand seller workflows, business rules, and operational constraints before locking any technical decisions.',
          ),
          CaseStep(
            title: 'System architecture',
            body:
                'Designed a scalable multi-tenant architecture with clear domain boundaries to safely support multiple sellers on shared infrastructure.',
          ),
          CaseStep(
            title: 'Backend-first implementation',
            body:
                'Implemented core backend domains first (catalog, orders, payments, deliveries) to ensure data integrity and predictable workflows.',
          ),
          CaseStep(
            title: 'Mobile-first experience',
            body:
                'Built the seller-facing mobile app with reusable UI components and consistent UX patterns tailored to real seller usage.',
          ),
          CaseStep(
            title: 'Iterative delivery',
            body:
                'Released features incrementally, validated assumptions with the client, and refined flows based on real-world feedback.',
          ),
        ],
        highlights: [
          'Multi-seller store creation and onboarding',
          'Product and multi-catalog management',
          'End-to-end order lifecycle tracking',
          'Delivery assignment and status workflows',
          'Subscription-based feature gating',
          'Multiple payment method support',
          'Scalable architecture ready for growth',
        ],
        challenges: [
          CaseChallenge(
            title: 'Multi-tenant data isolation',
            body:
                'Ensuring strict separation between sellers while sharing the same infrastructure. Solved using scoped queries, ownership checks, and clear domain boundaries.',
          ),
          CaseChallenge(
            title: 'Complex order and delivery states',
            body:
                'Orders and deliveries had many edge cases. Implemented explicit state enums and predictable workflows to avoid inconsistencies.',
          ),
          CaseChallenge(
            title: 'Subscription-based access control',
            body:
                'Different plans required different feature access. Solved with centralized plan rules and runtime capability checks.',
          ),
          CaseChallenge(
            title: 'Maintaining velocity as a solo freelancer',
            body:
                'Balanced speed and quality by building modular services and reusable UI components.',
          ),
        ],
        stack: [
          StackIcon.flutter,
          StackIcon.bloc,
          StackIcon.nodejs,
          StackIcon.typescript,
          StackIcon.postgresql,
          StackIcon.stripe,
          StackIcon.render,
          StackIcon.vercel,
        ],
        outcomes: [
          CaseMetric(
            label: 'Architecture',
            value: 'Production-ready & scalable',
          ),
          CaseMetric(label: 'Seller workflow', value: 'Fully centralized'),
          CaseMetric(
            label: 'Delivery handling',
            value: 'Automated status tracking',
          ),
          CaseMetric(
            label: 'Client status',
            value: 'Actively evolving platform',
          ),
        ],
        quote:
            'Delivered a solid technical foundation that allows us to onboard sellers and iterate quickly.',
        liveUrl: null, // client-owned / private
      ),

      CaseStudy(
        id: 'motiboutik-customer-web',
        tag: 'E-commerce',
        title: 'Motiboutik Custom Web Store',
        summary:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.',
        problem:
            'The previous web store was rigid and hard to scale for campaigns.',
        goal:
            'Build a flexible storefront with fast performance and integrations.',
        roleTimeline: 'Full-stack developer • 6 weeks • Solo',
        deliverables: 'Customer web store, CMS integration, analytics.',
        imageUrl: 'assets/images/projects_shots/motiboutik_customer_2.png',
        gallery: [
          'assets/images/projects_shots/motiboutik_customer_2.png',
          'assets/images/projects_shots/motiboutik_customer_2.png',
        ],
        accent: 'amber',
        approachSteps: [
          CaseStep(
            title: 'Requirements',
            body: 'Align marketing and ops on scope.',
          ),
          CaseStep(
            title: 'Design',
            body: 'Build modular components for campaigns.',
          ),
          CaseStep(
            title: 'Build',
            body: 'Implement storefront + backend APIs.',
          ),
          CaseStep(title: 'Launch', body: 'Analytics and monitoring setup.'),
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
        stack: [
          StackIcon.flutter,
          StackIcon.nodejs,
          StackIcon.postgresql,
          StackIcon.stripe,
        ],
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
