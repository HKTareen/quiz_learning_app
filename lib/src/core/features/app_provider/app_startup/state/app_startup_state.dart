import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_startup_state.freezed.dart';

@freezed
abstract class AppStartupState with _$AppStartupState {
  const AppStartupState._();

  const factory AppStartupState({
    required SharedPreferences sharedPreferences,
  }) = _AppStartupState;
}
