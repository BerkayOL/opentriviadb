import '../repositories/settings_repository.dart';

class SaveThemeModeUseCase {
  const SaveThemeModeUseCase(this._repository);

  final SettingsRepository _repository;

  Future<void> call(AppThemeMode mode) => _repository.saveThemeMode(mode);
}
