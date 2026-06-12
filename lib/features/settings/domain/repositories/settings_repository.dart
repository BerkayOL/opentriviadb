enum AppThemeMode { system, light, dark }

abstract interface class SettingsRepository {
  Future<AppThemeMode> getThemeMode();

  Future<void> saveThemeMode(AppThemeMode mode);
}
