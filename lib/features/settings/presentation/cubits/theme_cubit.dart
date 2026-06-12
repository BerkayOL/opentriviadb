import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/settings_repository.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState());

  Future<void> loadThemeMode() async {
    // TODO: Load saved theme mode through GetThemeModeUseCase.
  }

  Future<void> changeThemeMode(AppThemeMode mode) async {
    // TODO: Persist theme mode through SaveThemeModeUseCase.
    emit(ThemeState(mode: mode));
  }
}
