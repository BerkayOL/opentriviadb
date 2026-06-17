import 'package:get_it/get_it.dart';

import '../../features/settings/data/datasources/settings_local_datasource.dart';
import '../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../../features/settings/domain/usecases/get_theme_mode_usecase.dart';
import '../../features/settings/domain/usecases/save_theme_mode_usecase.dart';
import '../../features/settings/presentation/cubits/theme_cubit.dart';

void setupSettingsDependencies(GetIt getIt) {
  if (!getIt.isRegistered<SettingsLocalDataSource>()) {
    getIt.registerLazySingleton<SettingsLocalDataSource>(
      SettingsLocalDataSourceImpl.new,
    );
  }

  if (!getIt.isRegistered<SettingsRepository>()) {
    getIt.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(getIt<SettingsLocalDataSource>()),
    );
  }

  if (!getIt.isRegistered<GetThemeModeUseCase>()) {
    getIt.registerLazySingleton<GetThemeModeUseCase>(
      () => GetThemeModeUseCase(getIt<SettingsRepository>()),
    );
  }

  if (!getIt.isRegistered<SaveThemeModeUseCase>()) {
    getIt.registerLazySingleton<SaveThemeModeUseCase>(
      () => SaveThemeModeUseCase(getIt<SettingsRepository>()),
    );
  }

  if (!getIt.isRegistered<ThemeCubit>()) {
    getIt.registerFactory<ThemeCubit>(
      () => ThemeCubit(
        getThemeModeUseCase: getIt<GetThemeModeUseCase>(),
        saveThemeModeUseCase: getIt<SaveThemeModeUseCase>(),
      ),
    );
  }
}
