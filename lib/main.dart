import 'package:flutter/widgets.dart';
import 'package:hive_ce_flutter/adapters.dart';

import 'app/app.dart';
import 'app/dependency_injection/app_di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await setupAppDependencies();

  runApp(const TriviaQuizApp());
}
