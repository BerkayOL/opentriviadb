import '../../domain/repositories/settings_repository.dart';

abstract interface class SettingsLocalDataSource {
  Future<AppThemeMode> getThemeMode();

  Future<void> saveThemeMode(AppThemeMode mode);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  const SettingsLocalDataSourceImpl();

  @override
  Future<AppThemeMode> getThemeMode() {
    // TODO: Load theme mode from Hive.
    throw UnimplementedError();
  }

  @override
  Future<void> saveThemeMode(AppThemeMode mode) {
    // TODO: Save theme mode to Hive.
    throw UnimplementedError();
  }
}
