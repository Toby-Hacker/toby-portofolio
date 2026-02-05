import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toby_portfolio/l10n/app_localizations.dart';

import 'app/router/app_router.dart';
import 'core/localization/locale_controller.dart';
import 'core/theme/app_theme.dart';
import 'data/mock/mock_portfolio_repository.dart';
import 'domain/repositories/portfolio_repository.dart';
import 'features/home/bloc/portfolio_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  final LocaleController _localeController = LocaleController();

  @override
  void dispose() {
    _localeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PortfolioRepository repo = MockPortfolioRepository();

    return AnimatedBuilder(
      animation: _localeController,
      builder: (context, child) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider<PortfolioRepository>.value(value: repo),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => PortfolioBloc(repo)..add(const PortfolioStarted()),
              ),
            ],
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: ThemeMode.dark,
              locale: _localeController.locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              routerConfig: AppRouter.router,
              builder: (context, child) {
                return LocaleScope(
                  controller: _localeController,
                  child: child ?? const SizedBox.shrink(),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
