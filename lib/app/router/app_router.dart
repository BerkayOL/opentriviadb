import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../app/dependency_injection/app_di.dart';
import '../../features/history/presentation/pages/history_page.dart';
import '../../features/quiz/presentation/cubits/quiz_setup_cubit.dart';
import '../../features/quiz/presentation/pages/quiz_page.dart';
import '../../features/quiz/presentation/pages/quiz_result_page.dart';
import '../../features/quiz/presentation/pages/quiz_setup_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import 'app_routes.dart';

abstract final class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.setup,
    routes: [
      GoRoute(
        path: AppRoutes.setup,
        name: AppRoutes.setupName,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<QuizSetupCubit>()..loadCategories(),
          child: const QuizSetupPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.quiz,
        name: AppRoutes.quizName,
        builder: (context, state) => const QuizPage(),
      ),
      GoRoute(
        path: AppRoutes.result,
        name: AppRoutes.resultName,
        builder: (context, state) => const QuizResultPage(),
      ),
      GoRoute(
        path: AppRoutes.history,
        name: AppRoutes.historyName,
        builder: (context, state) => const HistoryPage(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        name: AppRoutes.settingsName,
        builder: (context, state) => const SettingsPage(),
      ),
    ],
  );
}
