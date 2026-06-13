import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/settings/data/datasources/settings_local_datasource.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../features/settings/domain/usecases/get_theme_mode_usecase.dart';
import '../../features/settings/domain/usecases/save_theme_mode_usecase.dart';
import '../../features/settings/presentation/cubits/theme_cubit.dart';

import '../../core/network/dio_client.dart';

import '../../features/history/data/datasources/history_local_datasource.dart';
import '../../features/history/data/repositories/history_repository_impl.dart';
import '../../features/history/domain/repositories/history_repository.dart';
import '../../features/history/domain/usecases/clear_history_usecase.dart';
import '../../features/history/domain/usecases/get_highest_score_usecase.dart';
import '../../features/history/domain/usecases/get_history_usecase.dart';
import '../../features/history/domain/usecases/save_quiz_history_usecase.dart';
import '../../features/history/presentation/cubits/history_cubit.dart';

import '../../features/quiz/data/datasources/quiz_local_datasource.dart';
import '../../features/quiz/data/datasources/quiz_remote_datasource.dart';
import '../../features/quiz/data/repositories/quiz_repository_impl.dart';
import '../../features/quiz/domain/repositories/quiz_repository.dart';
import '../../features/quiz/domain/usecases/get_categories_usecase.dart';
import '../../features/quiz/domain/usecases/get_questions_usecase.dart';
import '../../features/quiz/presentation/cubits/quiz_cubit.dart';
import '../../features/quiz/presentation/cubits/quiz_setup_cubit.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupAppDependencies() async {
  if (!getIt.isRegistered<Dio>()) {
    getIt.registerLazySingleton<Dio>(() => DioClient().create());
  }

  // Quiz data sources
  if (!getIt.isRegistered<QuizRemoteDataSource>()) {
    getIt.registerLazySingleton<QuizRemoteDataSource>(
      () => QuizRemoteDataSourceImpl(getIt<Dio>()),
    );
  }

  if (!getIt.isRegistered<QuizLocalDataSource>()) {
    getIt.registerLazySingleton<QuizLocalDataSource>(
      QuizLocalDataSourceImpl.new,
    );
  }

  // Quiz repository
  if (!getIt.isRegistered<QuizRepository>()) {
    getIt.registerLazySingleton<QuizRepository>(
      () => QuizRepositoryImpl(
        remoteDataSource: getIt<QuizRemoteDataSource>(),
        localDataSource: getIt<QuizLocalDataSource>(),
      ),
    );
  }

  // Quiz use cases
  if (!getIt.isRegistered<GetCategoriesUseCase>()) {
    getIt.registerLazySingleton<GetCategoriesUseCase>(
      () => GetCategoriesUseCase(getIt<QuizRepository>()),
    );
  }

  if (!getIt.isRegistered<GetQuestionsUseCase>()) {
    getIt.registerLazySingleton<GetQuestionsUseCase>(
      () => GetQuestionsUseCase(getIt<QuizRepository>()),
    );
  }

  // History data source
  if (!getIt.isRegistered<HistoryLocalDataSource>()) {
    getIt.registerLazySingleton<HistoryLocalDataSource>(
      HistoryLocalDataSourceImpl.new,
    );
  }

  // History repository
  if (!getIt.isRegistered<HistoryRepository>()) {
    getIt.registerLazySingleton<HistoryRepository>(
      () => HistoryRepositoryImpl(getIt<HistoryLocalDataSource>()),
    );
  }

  // History use cases
  if (!getIt.isRegistered<GetQuizHistoryUseCase>()) {
    getIt.registerLazySingleton<GetQuizHistoryUseCase>(
      () => GetQuizHistoryUseCase(getIt<HistoryRepository>()),
    );
  }

  if (!getIt.isRegistered<GetHighestScoreUseCase>()) {
    getIt.registerLazySingleton<GetHighestScoreUseCase>(
      () => GetHighestScoreUseCase(getIt<HistoryRepository>()),
    );
  }

  if (!getIt.isRegistered<ClearHistoryUseCase>()) {
    getIt.registerLazySingleton<ClearHistoryUseCase>(
      () => ClearHistoryUseCase(getIt<HistoryRepository>()),
    );
  }

  if (!getIt.isRegistered<SaveQuizHistoryUseCase>()) {
    getIt.registerLazySingleton<SaveQuizHistoryUseCase>(
      () => SaveQuizHistoryUseCase(getIt<HistoryRepository>()),
    );
  }
  //Settings dependencies
  if (!getIt.isRegistered<SettingsLocalDataSource>()) {
    getIt.registerLazySingleton<SettingsLocalDataSource>(
      () => SettingsLocalDataSourceImpl(),
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
  // Quiz cubits
  if (!getIt.isRegistered<QuizSetupCubit>()) {
    getIt.registerFactory<QuizSetupCubit>(
      () => QuizSetupCubit(getIt<GetCategoriesUseCase>()),
    );
  }

  if (!getIt.isRegistered<QuizCubit>()) {
    getIt.registerFactory<QuizCubit>(
      () => QuizCubit(
        getIt<GetQuestionsUseCase>(),
        getIt<SaveQuizHistoryUseCase>(),
      ),
    );
  }
  // History cubit
  if (!getIt.isRegistered<HistoryCubit>()) {
    getIt.registerFactory<HistoryCubit>(
      () => HistoryCubit(
        getQuizHistoryUseCase: getIt<GetQuizHistoryUseCase>(),
        getHighestScoreUseCase: getIt<GetHighestScoreUseCase>(),
        clearHistoryUseCase: getIt<ClearHistoryUseCase>(),
      ),
    );
  }
}
