import 'package:flutter/material.dart' as material;
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'current_localization_provider.dart';

part 'language_direction_provider.g.dart';

@Riverpod(keepAlive: true)
material.TextDirection languageDirection(Ref ref) {
  return Bidi.isRtlLanguage(ref.watch(currentLocalizationProvider).languageCode)
      ? material.TextDirection.rtl
      : material.TextDirection.ltr;
}
