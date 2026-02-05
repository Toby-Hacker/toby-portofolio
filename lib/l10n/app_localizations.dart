import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @nav_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get nav_home;

  /// No description provided for @nav_case_studies.
  ///
  /// In en, this message translates to:
  /// **'Case Studies'**
  String get nav_case_studies;

  /// No description provided for @nav_testimonials.
  ///
  /// In en, this message translates to:
  /// **'Testimonials'**
  String get nav_testimonials;

  /// No description provided for @nav_recent_work.
  ///
  /// In en, this message translates to:
  /// **'Recent work'**
  String get nav_recent_work;

  /// No description provided for @nav_get_in_touch.
  ///
  /// In en, this message translates to:
  /// **'Get In Touch'**
  String get nav_get_in_touch;

  /// No description provided for @hero_title.
  ///
  /// In en, this message translates to:
  /// **'Your Name Here'**
  String get hero_title;

  /// No description provided for @hero_intro.
  ///
  /// In en, this message translates to:
  /// **'Intro text: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'**
  String get hero_intro;

  /// No description provided for @hero_cta.
  ///
  /// In en, this message translates to:
  /// **'Let’s get started'**
  String get hero_cta;

  /// No description provided for @hero_worked_with.
  ///
  /// In en, this message translates to:
  /// **'Worked with'**
  String get hero_worked_with;

  /// No description provided for @case_studies_title.
  ///
  /// In en, this message translates to:
  /// **'Case Studies'**
  String get case_studies_title;

  /// No description provided for @case_studies_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Some of the projects I’ve worked on, showing how I approach real problems and build practical solutions.'**
  String get case_studies_subtitle;

  /// No description provided for @case_study_view.
  ///
  /// In en, this message translates to:
  /// **'View case study'**
  String get case_study_view;

  /// No description provided for @testimonials_title.
  ///
  /// In en, this message translates to:
  /// **'Testimonials'**
  String get testimonials_title;

  /// No description provided for @testimonials_subtitle.
  ///
  /// In en, this message translates to:
  /// **'A few words from people I’ve had the chance to work with.'**
  String get testimonials_subtitle;

  /// No description provided for @recent_work_title.
  ///
  /// In en, this message translates to:
  /// **'Recent Work'**
  String get recent_work_title;

  /// No description provided for @recent_work_subtitle.
  ///
  /// In en, this message translates to:
  /// **'A selection of my most recent work.'**
  String get recent_work_subtitle;

  /// No description provided for @recent_work_know_more.
  ///
  /// In en, this message translates to:
  /// **'Know more'**
  String get recent_work_know_more;

  /// No description provided for @contact_title.
  ///
  /// In en, this message translates to:
  /// **'Get In Touch'**
  String get contact_title;

  /// No description provided for @contact_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Let’s talk about your project.'**
  String get contact_subtitle;

  /// No description provided for @contact_email_label.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get contact_email_label;

  /// No description provided for @contact_email_hint.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get contact_email_hint;

  /// No description provided for @contact_mobile_label.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get contact_mobile_label;

  /// No description provided for @contact_mobile_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter mobile'**
  String get contact_mobile_hint;

  /// No description provided for @contact_message_label.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get contact_message_label;

  /// No description provided for @contact_message_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your message'**
  String get contact_message_hint;

  /// No description provided for @contact_submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get contact_submit;

  /// No description provided for @case_details_not_found.
  ///
  /// In en, this message translates to:
  /// **'Case study not found'**
  String get case_details_not_found;

  /// No description provided for @case_details_view_live.
  ///
  /// In en, this message translates to:
  /// **'View live'**
  String get case_details_view_live;

  /// No description provided for @case_details_project_overview_title.
  ///
  /// In en, this message translates to:
  /// **'Project Overview'**
  String get case_details_project_overview_title;

  /// No description provided for @case_details_project_overview_subtitle.
  ///
  /// In en, this message translates to:
  /// **'A quick look at the problem, goals, and scope of the project.'**
  String get case_details_project_overview_subtitle;

  /// No description provided for @case_details_problem_title.
  ///
  /// In en, this message translates to:
  /// **'Problem'**
  String get case_details_problem_title;

  /// No description provided for @case_details_problem_body.
  ///
  /// In en, this message translates to:
  /// **'Legacy tooling slowed down onboarding and reporting for internal teams.'**
  String get case_details_problem_body;

  /// No description provided for @case_details_goal_title.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get case_details_goal_title;

  /// No description provided for @case_details_goal_body.
  ///
  /// In en, this message translates to:
  /// **'Deliver a faster, mobile-first experience with reliable data syncing.'**
  String get case_details_goal_body;

  /// No description provided for @case_details_role_title.
  ///
  /// In en, this message translates to:
  /// **'Role & Timeline'**
  String get case_details_role_title;

  /// No description provided for @case_details_role_body.
  ///
  /// In en, this message translates to:
  /// **'Full-stack mobile developer • 8 weeks • 2 teammates'**
  String get case_details_role_body;

  /// No description provided for @case_details_deliverables_title.
  ///
  /// In en, this message translates to:
  /// **'Deliverables'**
  String get case_details_deliverables_title;

  /// No description provided for @case_details_deliverables_body.
  ///
  /// In en, this message translates to:
  /// **'iOS/Android apps, admin dashboard, analytics, and CI/CD.'**
  String get case_details_deliverables_body;

  /// No description provided for @case_details_approach_title.
  ///
  /// In en, this message translates to:
  /// **'Approach'**
  String get case_details_approach_title;

  /// No description provided for @case_details_approach_subtitle.
  ///
  /// In en, this message translates to:
  /// **'How the project moved from discovery to delivery.'**
  String get case_details_approach_subtitle;

  /// No description provided for @case_details_step_1_title.
  ///
  /// In en, this message translates to:
  /// **'Discovery'**
  String get case_details_step_1_title;

  /// No description provided for @case_details_step_1_body.
  ///
  /// In en, this message translates to:
  /// **'User interviews + flow mapping.'**
  String get case_details_step_1_body;

  /// No description provided for @case_details_step_2_title.
  ///
  /// In en, this message translates to:
  /// **'Design'**
  String get case_details_step_2_title;

  /// No description provided for @case_details_step_2_body.
  ///
  /// In en, this message translates to:
  /// **'Wireframes and UI kit for fast build.'**
  String get case_details_step_2_body;

  /// No description provided for @case_details_step_3_title.
  ///
  /// In en, this message translates to:
  /// **'Build'**
  String get case_details_step_3_title;

  /// No description provided for @case_details_step_3_body.
  ///
  /// In en, this message translates to:
  /// **'Flutter app + backend services.'**
  String get case_details_step_3_body;

  /// No description provided for @case_details_step_4_title.
  ///
  /// In en, this message translates to:
  /// **'Launch'**
  String get case_details_step_4_title;

  /// No description provided for @case_details_step_4_body.
  ///
  /// In en, this message translates to:
  /// **'Monitoring, analytics, and handoff.'**
  String get case_details_step_4_body;

  /// No description provided for @case_details_highlights_title.
  ///
  /// In en, this message translates to:
  /// **'Highlights'**
  String get case_details_highlights_title;

  /// No description provided for @case_details_highlights_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Key features delivered for the project.'**
  String get case_details_highlights_subtitle;

  /// No description provided for @case_details_tech_stack_title.
  ///
  /// In en, this message translates to:
  /// **'Tech Stack'**
  String get case_details_tech_stack_title;

  /// No description provided for @case_details_tech_stack_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Tools and frameworks used in the build.'**
  String get case_details_tech_stack_subtitle;

  /// No description provided for @case_details_challenges_title.
  ///
  /// In en, this message translates to:
  /// **'Challenges & Solutions'**
  String get case_details_challenges_title;

  /// No description provided for @case_details_challenges_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Key tradeoffs and how they were resolved.'**
  String get case_details_challenges_subtitle;

  /// No description provided for @case_details_challenge_1_title.
  ///
  /// In en, this message translates to:
  /// **'Offline reliability'**
  String get case_details_challenge_1_title;

  /// No description provided for @case_details_challenge_1_body.
  ///
  /// In en, this message translates to:
  /// **'Added local caching with queued sync when connectivity returns.'**
  String get case_details_challenge_1_body;

  /// No description provided for @case_details_challenge_2_title.
  ///
  /// In en, this message translates to:
  /// **'Performance under load'**
  String get case_details_challenge_2_title;

  /// No description provided for @case_details_challenge_2_body.
  ///
  /// In en, this message translates to:
  /// **'Optimized API responses and reduced payload size by 35%.'**
  String get case_details_challenge_2_body;

  /// No description provided for @case_details_outcome_title.
  ///
  /// In en, this message translates to:
  /// **'Outcome'**
  String get case_details_outcome_title;

  /// No description provided for @case_details_outcome_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Results delivered after launch.'**
  String get case_details_outcome_subtitle;

  /// No description provided for @case_details_quote.
  ///
  /// In en, this message translates to:
  /// **'“Great collaboration and execution. The product is faster and more reliable than before.”'**
  String get case_details_quote;

  /// No description provided for @case_details_next_title.
  ///
  /// In en, this message translates to:
  /// **'Next Case Study'**
  String get case_details_next_title;

  /// No description provided for @case_details_next_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Explore another project in the portfolio.'**
  String get case_details_next_subtitle;

  /// No description provided for @case_details_metric_users_label.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get case_details_metric_users_label;

  /// No description provided for @case_details_metric_uptime_label.
  ///
  /// In en, this message translates to:
  /// **'Uptime'**
  String get case_details_metric_uptime_label;

  /// No description provided for @case_details_metric_revenue_label.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get case_details_metric_revenue_label;

  /// No description provided for @case_details_metric_retention_label.
  ///
  /// In en, this message translates to:
  /// **'Retention'**
  String get case_details_metric_retention_label;

  /// No description provided for @case_details_metric_processing_time_label.
  ///
  /// In en, this message translates to:
  /// **'Processing time'**
  String get case_details_metric_processing_time_label;

  /// No description provided for @case_details_metric_nps_label.
  ///
  /// In en, this message translates to:
  /// **'NPS'**
  String get case_details_metric_nps_label;

  /// No description provided for @recent_details_not_found.
  ///
  /// In en, this message translates to:
  /// **'Recent work not found'**
  String get recent_details_not_found;

  /// No description provided for @recent_details_visit_project.
  ///
  /// In en, this message translates to:
  /// **'Visit project'**
  String get recent_details_visit_project;

  /// No description provided for @recent_details_project_overview_title.
  ///
  /// In en, this message translates to:
  /// **'Project Overview'**
  String get recent_details_project_overview_title;

  /// No description provided for @recent_details_project_overview_subtitle.
  ///
  /// In en, this message translates to:
  /// **'A quick summary of the work delivered and why it mattered.'**
  String get recent_details_project_overview_subtitle;

  /// No description provided for @recent_details_scope_title.
  ///
  /// In en, this message translates to:
  /// **'Scope'**
  String get recent_details_scope_title;

  /// No description provided for @recent_details_scope_body.
  ///
  /// In en, this message translates to:
  /// **'End-to-end delivery with focus on mobile experience.'**
  String get recent_details_scope_body;

  /// No description provided for @recent_details_role_title.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get recent_details_role_title;

  /// No description provided for @recent_details_role_body.
  ///
  /// In en, this message translates to:
  /// **'Full-stack mobile development and release planning.'**
  String get recent_details_role_body;

  /// No description provided for @recent_details_timeline_title.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get recent_details_timeline_title;

  /// No description provided for @recent_details_timeline_body.
  ///
  /// In en, this message translates to:
  /// **'6 weeks from discovery to launch.'**
  String get recent_details_timeline_body;

  /// No description provided for @recent_details_deliverables_title.
  ///
  /// In en, this message translates to:
  /// **'Deliverables'**
  String get recent_details_deliverables_title;

  /// No description provided for @recent_details_deliverables_body.
  ///
  /// In en, this message translates to:
  /// **'Mobile apps, backend services, and analytics.'**
  String get recent_details_deliverables_body;

  /// No description provided for @recent_details_highlights_title.
  ///
  /// In en, this message translates to:
  /// **'Highlights'**
  String get recent_details_highlights_title;

  /// No description provided for @recent_details_highlights_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Key wins and improvements from this work.'**
  String get recent_details_highlights_subtitle;

  /// No description provided for @recent_details_highlight_1.
  ///
  /// In en, this message translates to:
  /// **'Shipped new flows for onboarding and core features.'**
  String get recent_details_highlight_1;

  /// No description provided for @recent_details_highlight_2.
  ///
  /// In en, this message translates to:
  /// **'Improved performance and reliability metrics.'**
  String get recent_details_highlight_2;

  /// No description provided for @recent_details_highlight_3.
  ///
  /// In en, this message translates to:
  /// **'Reduced support tickets with clearer UX.'**
  String get recent_details_highlight_3;

  /// No description provided for @recent_details_tech_stack_title.
  ///
  /// In en, this message translates to:
  /// **'Tech Stack'**
  String get recent_details_tech_stack_title;

  /// No description provided for @recent_details_tech_stack_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Tools and frameworks used in the build.'**
  String get recent_details_tech_stack_subtitle;

  /// No description provided for @recent_details_outcome_title.
  ///
  /// In en, this message translates to:
  /// **'Outcome'**
  String get recent_details_outcome_title;

  /// No description provided for @recent_details_outcome_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Results delivered after launch.'**
  String get recent_details_outcome_subtitle;

  /// No description provided for @recent_details_metric_retention_label.
  ///
  /// In en, this message translates to:
  /// **'Retention'**
  String get recent_details_metric_retention_label;

  /// No description provided for @recent_details_metric_latency_label.
  ///
  /// In en, this message translates to:
  /// **'Latency'**
  String get recent_details_metric_latency_label;

  /// No description provided for @recent_details_metric_crash_rate_label.
  ///
  /// In en, this message translates to:
  /// **'Crash rate'**
  String get recent_details_metric_crash_rate_label;

  /// No description provided for @recent_details_back_home.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get recent_details_back_home;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
