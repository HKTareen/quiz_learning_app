import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../local_data/preferences/preferences_service.dart';

part 'current_localization_provider.g.dart';

@riverpod
class CurrentLocalization extends _$CurrentLocalization {
  @override
  Locale build() {
    final lang = ref.watch(preferencesServiceProvider).selectedLang;
    return Locale(lang);
  }

  Future<void> change(String lang) async {
    state = Locale(lang);
    await ref.read(preferencesServiceProvider).saveLanguage(lang);

    final _ = ref.refresh(preferencesServiceProvider);
  }
}
