import 'package:equatable/equatable.dart';

class SocialLink extends Equatable {
  final String label;
  final String url;
  const SocialLink({required this.label, required this.url});

  @override
  List<Object?> get props => [label, url];
}

class PartnerLogo extends Equatable {
  final String name;
  const PartnerLogo(this.name);

  @override
  List<Object?> get props => [name];
}

class CaseStudy extends Equatable {
  final String id;
  final String tag;
  final String title;
  final String summary;
  final String imageUrl;
  final String accent; // amber | blue | teal
  final List<String> highlights;
  final List<String> stack;

  const CaseStudy({
    required this.id,
    required this.tag,
    required this.title,
    required this.summary,
    required this.imageUrl,
    required this.accent,
    required this.highlights,
    required this.stack,
  });

  @override
  List<Object?> get props => [id, tag, title, summary, imageUrl, accent, highlights, stack];
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
