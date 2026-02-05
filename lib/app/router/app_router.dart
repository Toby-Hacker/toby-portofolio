import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/details/case_study_details_page.dart';
import '../../features/home/home_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    routes: <RouteBase>[
      GoRoute(path: '/', builder: (context, state) => const HomePage()),
      GoRoute(
        path: '/case-study/:id',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return MaterialPage(child: CaseStudyDetailsPage(caseStudyId: id));
        },
      ),
      GoRoute(
        path: '/work/:id',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return MaterialPage(child: Placeholder());
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      backgroundColor: const Color(0xFF080808),
      body: Center(
        child: Text(
          state.error?.toString() ?? 'Not found',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}
