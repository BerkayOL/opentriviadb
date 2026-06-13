import '../entities/app_theme_mode.dart';
import '../repositories/settings_repository.dart';

class SaveThemeModeUseCase {
  const SaveThemeModeUseCase(this._repository);

  final SettingsRepository _repository;

  Future<void> call(AppThemeMode mode) {
    return _repository.saveThemeMode(mode);
  }
}
