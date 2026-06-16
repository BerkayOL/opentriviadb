import 'package:flutter/widgets.dart';
import 'package:opentriviadb/app/bootstrap/app_bootstrap.dart';

import 'app/app.dart';

Future<void> main() async {
  await AppBootstrap.appStart();
  runApp(TriviaQuizApp());
}
