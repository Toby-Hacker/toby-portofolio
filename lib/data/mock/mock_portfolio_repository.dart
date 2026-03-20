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
        StackIcon.flutter,
        StackIcon.firebase,
        StackIcon.nodejs,
        StackIcon.nextjs,
        StackIcon.googleCloud,
        StackIcon.aws,
        StackIcon.stripe,
        StackIcon.chatgpt,
      ],
      socials: [
        SocialLink(label: 'in', url: 'https://www.linkedin.com/'),
        SocialLink(label: 'Be', url: 'https://www.behance.net/'),
        SocialLink(label: 'tw', url: 'https://twitter.com/'),
      ],
    );

    const caseStudies = <CaseStudy>[
      CaseStudy(
        id: 'explotel-mobile-guest',
        tag: 'Mobile App',
        title: 'Explotel Mobile App — Guest Experience',
        summary:
            'A mobile application that allows users to discover events and experiences, '
            'book tickets securely, manage reservations, and attend events using digital tickets.',
        problem:
            'Event discovery and ticket booking in emerging markets is often fragmented, '
            'unreliable, and poorly adapted to mobile-first users. Guests face unclear pricing, '
            'unstable payment flows, and limited visibility on cancellations, refunds, and ticket validity.',
        goal:
            'Design and build a reliable, mobile-first guest experience that simplifies event discovery, '
            'secure booking, digital ticket access, and post-event interactions, while integrating '
            'complex payment and refund rules transparently.',
        roleTimeline:
            'Backend & Mobile Engineer — Greenfield project\n'
            'I built the Explotel mobile app (Guest mode) and co-designed the backend architecture, '
            'working closely with other developers from initial design to production.',
        deliverables:
            '• Flutter mobile application (Guest mode)\n'
            '• Secure booking and payment flows\n'
            '• Digital ticket management\n'
            '• Refund and cancellation handling\n'
            '• Backend APIs supporting mobile use cases',
        imageUrl: 'assets/images/projects_shots/explotel_mob_3.png',
        gallery: [
          'assets/images/projects_shots/explotel-mobile-app/explotel-mobile-app-1.png',
          'assets/images/projects_shots/explotel-mobile-app/explotel-mobile-app-2.png',
          'assets/images/projects_shots/explotel-mobile-app/explotel-mobile-app-3.png',
          'assets/images/projects_shots/explotel-mobile-app/explotel-mobile-app-4.png',
          'assets/images/projects_shots/explotel-mobile-app/explotel-mobile-app-5.png',
          'assets/images/projects_shots/explotel-mobile-app/explotel-mobile-app-6.png',
          'assets/images/projects_shots/explotel-mobile-app/explotel-mobile-app-7.png',
          'assets/images/projects_shots/explotel-mobile-app/explotel-mobile-app-8.png',
        ],
        accent: 'blue',

        approachSteps: [
          CaseStep(
            title: 'Mobile-first architecture',
            body:
                'Designed the guest experience with a mobile-first mindset, focusing on clarity, '
                'speed, and reliability for users discovering and booking events on their phones.',
          ),
          CaseStep(
            title: 'Clear separation of business models',
            body:
                'Implemented distinct data models and flows for Events and Experiences, '
                'allowing different booking rules, cancellation policies, and refund logic.',
          ),
          CaseStep(
            title: 'Robust payment integration',
            body:
                'Integrated Fedapay and Pawapay to support local payment methods, '
                'with backend logic handling percentage + fixed service fees and partial refunds.',
          ),
          CaseStep(
            title: 'Failure-tolerant booking flow',
            body:
                'Designed the system to handle edge cases where payments succeed but booking creation fails, '
                'allowing administrators to safely relaunch bookings without double charges.',
          ),
          CaseStep(
            title: 'Digital ticket lifecycle',
            body:
                'Built digital ticket access for guests, ensuring tickets remain secure, '
                'traceable, and ready for scanning at event entrances.',
          ),
        ],

        highlights: [
          'End-to-end Flutter guest application',
          'Complex booking and refund logic',
          'Multi-provider payment integration',
          'Clear separation between Event and Experience flows',
          'Designed for real-world operational edge cases',
        ],

        challenges: [
          CaseChallenge(
            title: 'Payment reliability',
            body:
                'Handling inconsistent network conditions and ensuring payment state consistency '
                'between mobile clients, payment providers, and backend services.',
          ),
          CaseChallenge(
            title: 'Refund and cancellation rules',
            body:
                'Implementing partial refunds and cancellation penalties while keeping the user '
                'experience simple and transparent.',
          ),
          CaseChallenge(
            title: 'Data consistency',
            body:
                'Ensuring bookings, tickets, and payments remain synchronized across systems, '
                'even in failure or retry scenarios.',
          ),
        ],

        stack: [
          StackIcon.flutter,
          StackIcon.dart,
          StackIcon.nodejs,
          StackIcon.postgresql,
          StackIcon.fedapay,
          StackIcon.pawapay,
          StackIcon.twilio,
        ],

        outcomes: [
          CaseMetric(label: 'Platforms', value: 'Android & iOS'),
          CaseMetric(label: 'Payment Providers', value: '2 integrated'),
          CaseMetric(label: 'Refund Support', value: 'Partial & full'),
          CaseMetric(label: 'Project Type', value: 'Greenfield'),
        ],

        quote:
            'This project pushed me to design mobile systems that are resilient to real-world failures, '
            'especially around payments and bookings.',
        liveUrl: 'https://www.explotel.com',
      ),
      CaseStudy(
        id: 'motiboutik',
        tag: 'E-commerce • Upwork',
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
          'assets/images/projects_shots/motiboutik-mobile-app/motiboutik-mobile-app-2.png',
          'assets/images/projects_shots/motiboutik-mobile-app/motiboutik-mobile-app-3.png',
          'assets/images/projects_shots/motiboutik-mobile-app/motiboutik-mobile-app-4.png',
          'assets/images/projects_shots/motiboutik-mobile-app/motiboutik-mobile-app-5.png',
          'assets/images/projects_shots/motiboutik-mobile-app/motiboutik-mobile-app-6.png',
          'assets/images/projects_shots/motiboutik-mobile-app/motiboutik-mobile-app-7.png',
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
        id: 'motiboutik-web-store',
        tag: 'E-commerce • Upwork',
        title: 'Motiboutik Web Store — Customer-facing Storefront',
        summary:
            'A fast, mobile-first web storefront that lets customers browse products, place orders, and pay online, built to support both platform subdomains and seller-owned custom domains.',
        problem:
            'The client needed a scalable customer-facing store that sellers could share as a link, without forcing customers to install an app. The store had to be fast, brandable, support custom domains, and handle real purchase flows reliably.',
        goal:
            'Deliver a performant, SEO-friendly storefront that increases conversion, works seamlessly on mobile, and allows sellers to use either a Motiboutik subdomain or their own custom domain.',
        roleTimeline:
            'Freelance Full-Stack Developer (Upwork) • Parallel delivery with core platform • Solo developer',
        deliverables:
            'Customer web storefront, domain routing system, product listing and detail pages, cart and checkout flow, and backend integration.',
        imageUrl: 'assets/images/projects_shots/motiboutik_customer_2.png',
        gallery: [
          'assets/case_studies/motiboutik_web/home.png',
          'assets/case_studies/motiboutik_web/product.png',
          'assets/case_studies/motiboutik_web/cart.png',
          'assets/case_studies/motiboutik_web/checkout.png',
        ],
        accent: 'teal',
        approachSteps: const [
          CaseStep(
            title: 'Customer journey design',
            body:
                'Mapped the full buyer journey from store entry to checkout, focusing on simplicity, trust, and fast decision-making.',
          ),
          CaseStep(
            title: 'Domain & routing strategy',
            body:
                'Designed a flexible routing system to serve the same store via platform subdomains or seller-owned custom domains.',
          ),
          CaseStep(
            title: 'Mobile-first storefront',
            body:
                'Built responsive layouts optimized for mobile usage, where most customers discover and purchase products.',
          ),
          CaseStep(
            title: 'Checkout & payment flow',
            body:
                'Implemented a clear cart and checkout experience with minimal steps to reduce friction and drop-off.',
          ),
          CaseStep(
            title: 'Performance & scalability',
            body:
                'Optimized data loading and rendering to ensure fast page loads even as product catalogs grow.',
          ),
        ],
        highlights: [
          'Public storefront accessible without login',
          'Product listing and product detail pages',
          'Cart and checkout flow',
          'Support for platform subdomains and custom domains',
          'Mobile-first responsive design',
          'SEO-friendly URLs and metadata',
          'Real-time product availability',
          'Consistent branding per seller',
        ],
        challenges: const [
          CaseChallenge(
            title: 'Custom domain support',
            body:
                'Serving multiple sellers on their own domains required careful routing and domain resolution while keeping a single codebase.',
          ),
          CaseChallenge(
            title: 'Performance on low-end devices',
            body:
                'Many customers browse on low-end phones and unstable networks. Solved with lightweight UI and optimized API responses.',
          ),
          CaseChallenge(
            title: 'Consistent UX across many stores',
            body:
                'Ensured all stores follow the same UX standards while still allowing seller-specific branding.',
          ),
        ],
        stack: [
          StackIcon.flutterWeb,
          StackIcon.typescript,
          StackIcon.nodejs,
          StackIcon.postgresql,
          StackIcon.vercel,
        ],
        outcomes: [
          CaseMetric(label: 'Access', value: 'No app install required'),
          CaseMetric(
            label: 'Domains',
            value: 'Subdomain + custom domain support',
          ),
          CaseMetric(label: 'UX', value: 'Mobile-first conversion-focused'),
          CaseMetric(label: 'Scalability', value: 'Multi-store ready'),
        ],
        quote:
            'The storefront makes it easy for sellers to share their store and for customers to buy without friction.',
        liveUrl: null, // client-owned / private
      ),
      CaseStudy(
        id: 'dotaga-translate',
        tag: 'WordPress Plugin • SaaS Product',
        title:
            'Dotaga Translate — SEO-first Website Translation Plugin for WordPress',
        summary:
            'A translation plugin designed to help WordPress site owners turn a monolingual website into a multilingual one with dedicated translated URLs, SEO-friendly routing, language switchers, sitemap automation, and a full translation management workflow inside WordPress admin.',
        problem:
            'Most translation solutions for WordPress force a tradeoff: either fast but shallow instant translation, or heavy enterprise tools that are expensive, rigid, and difficult for smaller site owners to operate. Site owners also struggle with multilingual SEO, translated URL structures, incomplete translation states, and keeping translated pages updated as the original content changes.',
        goal:
            'Build a plugin that gives website owners a practical multilingual workflow: fast setup, clean translation management, support for both instant and dedicated translation modes, strong SEO behavior, and enough control to fit real content operations without overwhelming non-technical users.',
        roleTimeline:
            'Product Engineer / Full-Stack Developer • End-to-end ownership • Ongoing product development',
        deliverables:
            'WordPress plugin architecture, admin UI, setup wizard, settings system, translation engine, translation queue, translation file management, sitemap integration, page loader and routing logic, frontend language widgets, multilingual SEO handling, and supporting API integration.',
        imageUrl: 'assets/images/projects_shots/dotaga-translate/dotaga-translate-1.png',
        gallery: [
          'assets/images/projects_shots/dotaga-translate/dotaga-translate-1.png',
          'assets/images/projects_shots/dotaga-translate/dotaga-translate-2.png',
          'assets/images/projects_shots/dotaga-translate/dotaga-translate-3.png',
          'assets/images/projects_shots/dotaga-translate/dotaga-translate-4.png',
          'assets/images/projects_shots/dotaga-translate/dotaga-translate-5.png',
        ],
        accent: 'blue',
        approachSteps: [
          CaseStep(
            title: 'Product framing first',
            body:
                'Started from the real operational needs of multilingual websites rather than just “adding translation”. That meant thinking early about SEO, URL policies, update workflows, and failure cases, not only text conversion.',
          ),
          CaseStep(
            title: 'Dual-mode translation design',
            body:
                'Designed the plugin around two distinct usage models: instant translation for low-friction access, and dedicated translation mode for indexable multilingual pages with stronger long-term control.',
          ),
          CaseStep(
            title: 'Backend workflow architecture',
            body:
                'Built the translation pipeline around repositories, settings services, background jobs, translation files, and retry-aware queue processing to keep the system maintainable as features expanded.',
          ),
          CaseStep(
            title: 'Admin UX iteration',
            body:
                'Implemented a setup wizard, settings pages, language management, translation detail screens, and frontend controls with the goal of making a fairly technical product usable by non-technical site owners.',
          ),
          CaseStep(
            title: 'Edge-case driven refinement',
            body:
                'A lot of the work went into the details: translated URL generation, fallback behavior, incomplete translation thresholds, sitemap discovery, widget behavior, and keeping internal links and page routing coherent across languages.',
          ),
        ],
        highlights: [
          'Dedicated and instant translation modes',
          'SEO-friendly multilingual URL handling',
          'Automatic sitemap-based page discovery',
          'Background translation queue with retry logic',
          'Translation progress and per-page language control',
          'Frontend floating widget and shortcode switcher',
          'Browser-language suggestion flow',
          'Configurable fallback behavior for incomplete or disabled translations',
        ],
        challenges: [
          CaseChallenge(
            title: 'Balancing usability with configuration depth',
            body:
                'The product needed to serve both simple users and advanced multilingual setups. Solved by separating setup flow from deeper settings while keeping the model consistent underneath.',
          ),
          CaseChallenge(
            title: 'Multilingual routing and SEO correctness',
            body:
                'Generating translated URLs is only part of the problem. The harder part was handling canonical behavior, fallback rules, default language hiding, sitemap consistency, and invalid URL structure scenarios without breaking navigation.',
          ),
          CaseChallenge(
            title: 'Reliable background translation processing',
            body:
                'Translation jobs can fail for external reasons such as provider instability or malformed responses. Built queue locking, retries, status tracking, and cleanup logic so translation operations remain observable and recoverable.',
          ),
          CaseChallenge(
            title: 'Keeping translated content in sync over time',
            body:
                'Translation is not a one-time event. Added update flows, extraction methods, dictionary usage, and configurable auto-update behavior so translated pages can evolve with the source content.',
          ),
        ],
        stack: [
          StackIcon.php,
          StackIcon.wordpress,
          StackIcon.javascript,
          StackIcon.mysql,
          StackIcon.html,
          StackIcon.css,
        ],
        outcomes: [
          CaseMetric(
            label: 'Translation workflow',
            value: 'End-to-end inside WordPress',
          ),
          CaseMetric(
            label: 'SEO support',
            value: 'Dedicated multilingual URL model',
          ),
          CaseMetric(label: 'Operations', value: 'Queue-based and retry-aware'),
          CaseMetric(
            label: 'Product maturity',
            value: 'Actively iterated with growing scope',
          ),
        ],
        quote:
            'Built as a real product, not just a text-replacement tool — with routing, SEO, content lifecycle, and admin usability treated as first-class concerns.',
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
