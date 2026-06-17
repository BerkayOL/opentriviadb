import 'package:flutter/widgets.dart';
import '../app/bootstrap/app_bootstrap.dart';

import 'app/app.dart';

Future<void> main() async {
  await AppBootstrap.appStart();
  runApp(const TriviaQuizApp());
}
