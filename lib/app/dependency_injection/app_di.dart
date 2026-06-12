import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/quiz/domain/usecases/get_questions_usecase.dart';
import '../../features/quiz/presentation/cubits/quiz_cubit.dart';
import '../../core/network/dio_client.dart';
import '../../features/quiz/data/datasources/quiz_local_datasource.dart';
import '../../features/quiz/data/datasources/quiz_remote_datasource.dart';
import '../../features/quiz/data/repositories/quiz_repository_impl.dart';
import '../../features/quiz/domain/repositories/quiz_repository.dart';
import '../../features/quiz/domain/usecases/get_categories_usecase.dart';
import '../../features/quiz/presentation/cubits/quiz_setup_cubit.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupAppDependencies() async {
  if (!getIt.isRegistered<Dio>()) {
    getIt.registerLazySingleton<Dio>(() => DioClient().create());
  }

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

  if (!getIt.isRegistered<QuizRepository>()) {
    getIt.registerLazySingleton<QuizRepository>(
      () => QuizRepositoryImpl(
        remoteDataSource: getIt<QuizRemoteDataSource>(),
        localDataSource: getIt<QuizLocalDataSource>(),
      ),
    );
  }

  if (!getIt.isRegistered<GetCategoriesUseCase>()) {
    getIt.registerLazySingleton<GetCategoriesUseCase>(
      () => GetCategoriesUseCase(getIt<QuizRepository>()),
    );
  }

  if (!getIt.isRegistered<QuizSetupCubit>()) {
    getIt.registerFactory<QuizSetupCubit>(
      () => QuizSetupCubit(getIt<GetCategoriesUseCase>()),
    );
  }
  if (!getIt.isRegistered<GetQuestionsUseCase>()) {
    getIt.registerLazySingleton<GetQuestionsUseCase>(
      () => GetQuestionsUseCase(getIt<QuizRepository>()),
    );
  }
  if (!getIt.isRegistered<QuizCubit>()) {
    getIt.registerFactory<QuizCubit>(
      () => QuizCubit(getIt<GetQuestionsUseCase>()),
    );
  }
}
