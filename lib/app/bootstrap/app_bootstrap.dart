import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../dependency_injection/app_di.dart';

abstract final class AppBootstrap {
  const AppBootstrap._();
  static Future<void> appStart() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    await setupAppDependencies();
  }
}
