import 'package:get_it/get_it.dart';

import 'history_di.dart';
import 'quiz_di.dart';
import 'settings_di.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupAppDependencies() async {
  setupHistoryDependencies(getIt);
  setupSettingsDependencies(getIt);
  setupQuizDependencies(getIt);
}
