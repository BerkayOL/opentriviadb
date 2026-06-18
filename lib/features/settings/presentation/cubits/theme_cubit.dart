import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_strings.dart';
import '../../domain/entities/app_theme_mode.dart';
import '../../domain/usecases/get_theme_mode_usecase.dart';
import '../../domain/usecases/save_theme_mode_usecase.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({
    required GetThemeModeUseCase getThemeModeUseCase,
    required SaveThemeModeUseCase saveThemeModeUseCase,
  }) : _getThemeModeUseCase = getThemeModeUseCase,
       _saveThemeModeUseCase = saveThemeModeUseCase,
       super(const ThemeState());
  final GetThemeModeUseCase _getThemeModeUseCase;
  final SaveThemeModeUseCase _saveThemeModeUseCase;
  Future<void> loadThemeMode() async {
    emit(state.copyWith(status: ThemeStatus.loading, errorMessage: null));

    try {
      final appThemeMode = await _getThemeModeUseCase();
      final themeMode = _toFlutterThemeMode(appThemeMode);

      emit(
        state.copyWith(
          status: ThemeStatus.ready,
          themeMode: themeMode,
          errorMessage: null,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: ThemeStatus.failure,
          themeMode: ThemeMode.system,
          errorMessage: AppStrings.themeLoadError,
        ),
      );
    }
  }

  Future<void> changeThemeMode(ThemeMode mode) async {
    emit(
      state.copyWith(
        status: ThemeStatus.ready,
        themeMode: mode,
        errorMessage: null,
      ),
    );

    try {
      final appThemeMode = _toAppThemeMode(mode);
      await _saveThemeModeUseCase(appThemeMode);
    } catch (_) {
      emit(
        state.copyWith(
          status: ThemeStatus.failure,
          errorMessage: AppStrings.themeSaveError,
        ),
      );
    }
  }

  void clearErrorMessage() {
    if (state.errorMessage == null) {
      return;
    }

    emit(state.copyWith(errorMessage: null));
  }

  ThemeMode _toFlutterThemeMode(AppThemeMode mode) {
    return switch (mode) {
      AppThemeMode.system => ThemeMode.system,
      AppThemeMode.light => ThemeMode.light,
      AppThemeMode.dark => ThemeMode.dark,
    };
  }

  AppThemeMode _toAppThemeMode(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.system => AppThemeMode.system,
      ThemeMode.light => AppThemeMode.light,
      ThemeMode.dark => AppThemeMode.dark,
    };
  }
}
