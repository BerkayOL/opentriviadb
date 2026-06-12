import 'package:flutter/widgets.dart';

import 'app/app.dart';
import 'app/dependency_injection/app_di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupAppDependencies();

  runApp(const TriviaQuizApp());
}
