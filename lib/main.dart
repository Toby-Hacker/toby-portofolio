import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'data/mock/mock_portfolio_repository.dart';
import 'domain/repositories/portfolio_repository.dart';
import 'features/home/bloc/portfolio_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final PortfolioRepository repo = MockPortfolioRepository();

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
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
