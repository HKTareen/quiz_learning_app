import 'package:flutter/material.dart';

import '../base/l10n/app_localizations.dart';

mixin LocalizationMixin<T extends StatefulWidget> on State<T> {
  late AppLocalizations lang;
  late Locale locale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    locale = Localizations.localeOf(context);
    lang = AppLocalizations.of(context)!;
  }
}

extension BuildContextExtension on BuildContext {
  AppLocalizations get lang {
    return AppLocalizations.of(this)!;
  }
}
