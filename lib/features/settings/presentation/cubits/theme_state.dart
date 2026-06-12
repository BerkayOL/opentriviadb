import 'package:equatable/equatable.dart';

import '../../domain/repositories/settings_repository.dart';

class ThemeState extends Equatable {
  const ThemeState({this.mode = AppThemeMode.system});

  final AppThemeMode mode;

  @override
  List<Object?> get props => [mode];
}
