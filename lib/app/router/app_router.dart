import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:opentriviadb/features/app_shell/presentation/pages/app_shell_page.dart';
import '../../app/dependency_injection/app_di.dart';
import '../../features/history/presentation/pages/history_page.dart';
import '../../features/quiz/presentation/cubits/quiz_setup_cubit.dart';
import '../../features/quiz/presentation/cubits/quiz_cubit.dart';
import '../../features/quiz/domain/entities/quiz_request.dart';
import '../../features/quiz/presentation/pages/quiz_page.dart';
import '../../features/quiz/presentation/pages/quiz_setup_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/history/presentation/cubits/history_cubit.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import 'app_routes.dart';

abstract final class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,

    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: AppRoutes.splashName,
        builder: (context, state) => const SplashPage(),
      ),
      ShellRoute(
        builder: (context, state, child) => BlocProvider(
          create: (_) => getIt<QuizSetupCubit>()..loadCategories(),
          child: AppShellPage(child: child),
        ),
        routes: [
          GoRoute(
            path: AppRoutes.setup,
            name: AppRoutes.setupName,
            builder: (context, state) => const QuizSetupPage(),
          ),
          GoRoute(
            path: AppRoutes.history,
            name: AppRoutes.historyName,
            builder: (context, state) => BlocProvider(
              create: (_) => getIt<HistoryCubit>()..loadHistory(),
              child: const HistoryPage(),
            ),
          ),
          GoRoute(
            path: AppRoutes.settings,
            name: AppRoutes.settingsName,
            builder: (context, state) => const SettingsPage(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.quiz,
        name: AppRoutes.quizName,
        builder: (context, state) {
          final quizRequest = state.extra;
          if (quizRequest is! QuizRequest) {
            return const Scaffold(
              body: Center(child: Text('Invalid quiz request.')),
            );
          }
          return BlocProvider(
            create: (_) => getIt<QuizCubit>()..startQuiz(quizRequest),
            child: const QuizPage(),
          );
        },
      ),
    ],
  );
}
