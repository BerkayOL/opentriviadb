import 'package:get_it/get_it.dart';

import '../../features/history/data/datasources/history_local_datasource.dart';
import '../../features/history/data/repositories/history_repository_impl.dart';
import '../../features/history/domain/repositories/history_repository.dart';
import '../../features/history/domain/usecases/clear_history_usecase.dart';
import '../../features/history/domain/usecases/get_highest_score_usecase.dart';
import '../../features/history/domain/usecases/get_history_usecase.dart';
import '../../features/history/domain/usecases/save_quiz_history_usecase.dart';
import '../../features/history/presentation/cubits/history_cubit.dart';

void setupHistoryDependencies(GetIt getIt) {
  if (!getIt.isRegistered<HistoryLocalDataSource>()) {
    getIt.registerLazySingleton<HistoryLocalDataSource>(
      HistoryLocalDataSourceImpl.new,
    );
  }

  if (!getIt.isRegistered<HistoryRepository>()) {
    getIt.registerLazySingleton<HistoryRepository>(
      () => HistoryRepositoryImpl(getIt<HistoryLocalDataSource>()),
    );
  }

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
