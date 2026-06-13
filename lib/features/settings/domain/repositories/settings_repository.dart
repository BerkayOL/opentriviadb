import '../../domain/entities/app_theme_mode.dart';

abstract interface class SettingsRepository {
  Future<AppThemeMode> getThemeMode();

  Future<void> saveThemeMode(AppThemeMode mode);
}
