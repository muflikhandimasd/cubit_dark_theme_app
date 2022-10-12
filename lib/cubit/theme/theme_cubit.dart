import 'package:cubit_dark_theme_app/theme/services/theme_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part './theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(ThemeState(isLightTheme: ThemeDBService.getThemeSettings()));

  void lightMode() => emit(ThemeState(isLightTheme: true));

  void darkMode() => emit(ThemeState(isLightTheme: false));
}
