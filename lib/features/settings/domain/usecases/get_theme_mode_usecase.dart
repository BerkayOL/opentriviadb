import '../repositories/settings_repository.dart';

class GetThemeModeUseCase {
  const GetThemeModeUseCase(this._repository);

  final SettingsRepository _repository;

  Future<AppThemeMode> call() => _repository.getThemeMode();
}
