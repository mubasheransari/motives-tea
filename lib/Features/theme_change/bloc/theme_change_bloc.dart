import 'package:attendence_app/Features/theme_change/bloc/theme_change_event.dart';
import 'package:attendence_app/Features/theme_change/bloc/theme_change_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(themeMode: ThemeMode.light)) {
    on<ToggleThemeEvent>((event, emit) {
      emit(ThemeState(
        themeMode:
            state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
      ));
    });
  }
}
