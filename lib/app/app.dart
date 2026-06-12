import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import 'router/app_router.dart';

class TriviaQuizApp extends StatelessWidget {
  const TriviaQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Trivia Quiz',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      // TODO: Connect ThemeCubit when settings persistence is implemented.
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
