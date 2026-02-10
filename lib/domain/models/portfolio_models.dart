import 'package:equatable/equatable.dart';

import '../../core/constants/stack_icon.dart';

class SocialLink extends Equatable {
  final String label;
  final String url;
  const SocialLink({required this.label, required this.url});

  @override
  List<Object?> get props => [label, url];
}

class PartnerLogo extends Equatable {
  final String name;
  final String assetPath;
  const PartnerLogo({required this.name, required this.assetPath});

  @override
  List<Object?> get props => [name, assetPath];
}

class CaseStudy extends Equatable {
  final String id;
  final String tag;
  final String title;
  final String summary;
  final String problem;
  final String goal;
  final String roleTimeline;
  final String deliverables;
  final String imageUrl;
  final List<String> gallery;
  final String accent; // amber | blue | teal
  final List<CaseStep> approachSteps;
  final List<String> highlights;
  final List<CaseChallenge> challenges;
  final List<StackIcon> stack;
  final List<CaseMetric> outcomes;
  final String? quote;
  final String? liveUrl;

  const CaseStudy({
    required this.id,
    required this.tag,
    required this.title,
    required this.summary,
    required this.problem,
    required this.goal,
    required this.roleTimeline,
    required this.deliverables,
    required this.imageUrl,
    required this.gallery,
    required this.accent,
    required this.approachSteps,
    required this.highlights,
    required this.challenges,
    required this.stack,
    required this.outcomes,
    this.quote,
    this.liveUrl,
  });

  @override
  List<Object?> get props => [
    id,
    tag,
    title,
    summary,
    problem,
    goal,
    roleTimeline,
    deliverables,
    imageUrl,
    gallery,
    accent,
    approachSteps,
    highlights,
    challenges,
    stack,
    outcomes,
    quote,
    liveUrl,
  ];
}

class CaseChallenge extends Equatable {
  final String title;
  final String body;

  const CaseChallenge({required this.title, required this.body});

  @override
  List<Object?> get props => [title, body];
}

class CaseStep extends Equatable {
  final String title;
  final String body;

  const CaseStep({required this.title, required this.body});

  @override
  List<Object?> get props => [title, body];
}

class CaseMetric extends Equatable {
  final String label;
  final String value;

  const CaseMetric({required this.label, required this.value});

  @override
  List<Object?> get props => [label, value];
}

class RecentWork extends Equatable {
  final String id;
  final String title;
  final String summary;
  final String imageUrl;
  final List<String> stack;

  const RecentWork({
    required this.id,
    required this.title,
    required this.summary,
    required this.imageUrl,
    required this.stack,
  });

  @override
  List<Object?> get props => [id, title, summary, imageUrl, stack];
}

class Testimonial extends Equatable {
  final String id;
  final String quote;
  final String clientName;
  final String avatarUrl;

  const Testimonial({
    required this.id,
    required this.quote,
    required this.clientName,
    required this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, quote, clientName, avatarUrl];
}

class PortfolioProfile extends Equatable {
  final String name;
  final String intro;
  final String heroImageUrl;
  final List<PartnerLogo> workedWith;
  final List<SocialLink> socials;

  const PortfolioProfile({
    required this.name,
    required this.intro,
    required this.heroImageUrl,
    required this.workedWith,
    required this.socials,
  });

  @override
  List<Object?> get props => [name, intro, heroImageUrl, workedWith, socials];
}

class PortfolioData extends Equatable {
  final PortfolioProfile profile;
  final List<CaseStudy> caseStudies;
  final List<Testimonial> testimonials;
  final List<RecentWork> recentWork;

  const PortfolioData({
    required this.profile,
    required this.caseStudies,
    required this.testimonials,
    required this.recentWork,
  });

  @override
  List<Object?> get props => [profile, caseStudies, testimonials, recentWork];
}
