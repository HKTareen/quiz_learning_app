import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'preferences_provider.dart';

part 'preferences_service.g.dart';

class PreferencesService {
  PreferencesService(this._preferences);

  final SharedPreferences _preferences;

  static const _currentLang = 'selected-lang';
  static const _isSignIn = 'is-sign-in';

  Future<void> logOut() async => await _preferences.clear();

  String get selectedLang => _preferences.getString(_currentLang) ?? 'en';

  Future<bool> saveLanguage(String lang) async {
    return await _preferences.setString(_currentLang, lang);
  }

  TextDirection get direction {
    final lang = selectedLang;
    if (lang == 'ar') return TextDirection.rtl;
    return TextDirection.ltr;
  }

  bool get isSignIn => _preferences.getBool(_isSignIn) ?? false;

  Future<bool> saveSignIn(bool value) async {
    return await _preferences.setBool(_isSignIn, value);
  }
}

@riverpod
PreferencesService preferencesService(Ref ref) {
  return PreferencesService(ref.watch(sharedPreferencesProvider));
}
