import '../../../../features/settings/domain/entities/app_theme_mode.dart';

import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_datasource.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._localDataSource);

  final SettingsLocalDataSource _localDataSource;

  @override
  Future<AppThemeMode> getThemeMode() => _localDataSource.getThemeMode();

  @override
  Future<void> saveThemeMode(AppThemeMode mode) {
    return _localDataSource.saveThemeMode(mode);
  }
}
