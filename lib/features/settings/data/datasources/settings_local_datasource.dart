import 'package:hive_ce_flutter/hive_ce_flutter.dart';

import '../../domain/entities/app_theme_mode.dart';
import '../constants/settings_storage_keys.dart';

abstract interface class SettingsLocalDataSource {
  Future<AppThemeMode> getThemeMode();

  Future<void> saveThemeMode(AppThemeMode mode);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  const SettingsLocalDataSourceImpl();
  @override
  Future<AppThemeMode> getThemeMode() async {
    final box = await Hive.openBox<dynamic>(SettingsStorageKeys.boxName);
    final value = box.get(SettingsStorageKeys.themeMode);
    if (value == SettingsStorageKeys.lightThemeMode) {
      return AppThemeMode.light;
    }
    if (value == SettingsStorageKeys.darkThemeMode) {
      return AppThemeMode.dark;
    }
    return AppThemeMode.system;
  }

  @override
  Future<void> saveThemeMode(AppThemeMode mode) async {
    final box = await Hive.openBox(SettingsStorageKeys.boxName);
    final value = switch (mode) {
      AppThemeMode.light => SettingsStorageKeys.lightThemeMode,
      AppThemeMode.dark => SettingsStorageKeys.darkThemeMode,
      AppThemeMode.system => SettingsStorageKeys.systemThemeMode,
    };
    await box.put(SettingsStorageKeys.themeMode, value);
  }
}
