import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opentriviadb/core/constants/app_strings.dart';
import 'package:opentriviadb/features/settings/domain/entities/app_theme_mode.dart';
import 'package:opentriviadb/features/settings/domain/repositories/settings_repository.dart';
import 'package:opentriviadb/features/settings/domain/usecases/get_theme_mode_usecase.dart';
import 'package:opentriviadb/features/settings/domain/usecases/save_theme_mode_usecase.dart';
import 'package:opentriviadb/features/settings/presentation/cubits/theme_cubit.dart';
import 'package:opentriviadb/features/settings/presentation/cubits/theme_state.dart';
import 'package:opentriviadb/features/settings/presentation/pages/settings_page.dart';

void main() {
  group('ThemeCubit', () {
    test(
      'save failure keeps selected theme and exposes a consumable error',
      () async {
        final repository = _FailingSettingsRepository();
        final cubit = ThemeCubit(
          getThemeModeUseCase: GetThemeModeUseCase(repository),
          saveThemeModeUseCase: SaveThemeModeUseCase(repository),
        );

        await cubit.changeThemeMode(ThemeMode.dark);

        expect(cubit.state.status, ThemeStatus.failure);
        expect(cubit.state.themeMode, ThemeMode.dark);
        expect(cubit.state.errorMessage, AppStrings.themeSaveError);

        cubit.clearErrorMessage();

        expect(cubit.state.themeMode, ThemeMode.dark);
        expect(cubit.state.errorMessage, isNull);

        await cubit.close();
      },
    );

    testWidgets('settings page shows save failure as a snackbar', (
      tester,
    ) async {
      final repository = _FailingSettingsRepository();
      final cubit = ThemeCubit(
        getThemeModeUseCase: GetThemeModeUseCase(repository),
        saveThemeModeUseCase: SaveThemeModeUseCase(repository),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(value: cubit, child: const SettingsPage()),
        ),
      );

      await tester.tap(find.text(AppStrings.darkTheme));
      await tester.pump();

      expect(find.text(AppStrings.themeSaveError), findsOneWidget);
      expect(cubit.state.themeMode, ThemeMode.dark);
      expect(cubit.state.errorMessage, isNull);

      await cubit.close();
    });
  });
}

class _FailingSettingsRepository implements SettingsRepository {
  @override
  Future<AppThemeMode> getThemeMode() async {
    return AppThemeMode.system;
  }

  @override
  Future<void> saveThemeMode(AppThemeMode mode) async {
    throw StateError('Theme save failed.');
  }
}
