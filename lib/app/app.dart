import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app/dependency_injection/app_di.dart';
import '../core/constants/app_strings.dart';
import '../features/settings/presentation/cubits/theme_cubit.dart';
import '../features/settings/presentation/cubits/theme_state.dart';
import '../core/theme/app_theme.dart';
import 'router/app_router.dart';

class TriviaQuizApp extends StatelessWidget {
  const TriviaQuizApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>(
      create: (context) => getIt<ThemeCubit>()..loadThemeMode(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
