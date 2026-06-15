import 'package:flutter_bloc/flutter_bloc.dart';

class NavItemPressCubit extends Cubit<bool> {
  NavItemPressCubit() : super(false);

  void setPressed(bool value) => emit(value);
}
