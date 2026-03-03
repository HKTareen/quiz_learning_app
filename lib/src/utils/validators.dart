import '../base/l10n/app_localizations.dart';

sealed class Validators {
  static String? emailValidator(String? value, AppLocalizations lang) {
    if (value == null || value.isEmpty) {
      return lang.pleaseEnterEmail;
    }
    return null;
  }

  static String? passwordValidator(String? value, AppLocalizations lang) {
    if (value == null || value.isEmpty) {
      return lang.pleaseEnterPassword;
    }
    return null;
  }
}
