import 'package:hive_ce_flutter/hive_ce_flutter.dart';

import '../../domain/entities/app_theme_mode.dart';

abstract interface class SettingsLocalDataSource {
  Future<AppThemeMode> getThemeMode();

  Future<void> saveThemeMode(AppThemeMode mode);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  const SettingsLocalDataSourceImpl();
  static const String _boxName = 'settings';
  static const String _themeModeKey = 'theme_mode';
  @override
  Future<AppThemeMode> getThemeMode() async {
    final box = await Hive.openBox<dynamic>(_boxName);
    final value = box.get(_themeModeKey);
    if (value == 'light') {
      return AppThemeMode.light;
    }
    if (value == 'dark') {
      return AppThemeMode.dark;
    }
    return AppThemeMode.system;
  }

  @override
  Future<void> saveThemeMode(AppThemeMode mode) async {
    final box = await Hive.openBox(_boxName);
    final value = switch (mode) {
      AppThemeMode.light => 'light',
      AppThemeMode.dark => 'dark',
      AppThemeMode.system => 'system',
    };
    await box.put(_themeModeKey, value);
  }
}
