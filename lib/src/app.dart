import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'base/l10n/app_localizations.dart';
import 'base/theme/app_theme.dart';
import 'binding.dart';
import 'core/features/app_provider/localization/current_localization_provider.dart';
import 'core/features/app_provider/localization/language_direction_provider.dart';
import 'core/features/app_provider/snackbar/snackbar_provider.dart';
import 'router/router.dart';
import 'utils/awaiter.dart';
import 'utils/default_awaiter_behaviour.dart';
import 'widget/app_startup_widget.dart';

class QuizLearningApp extends ConsumerWidget {
  const QuizLearningApp._();

  static Future<void> initializeAndRun() async {
    final binding = WidgetsFlutterBinding.ensureInitialized();
    final mySpaceBinding = AppQuizLearningAppBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: binding);
    Awaiter.defaultBehaviour = DefaultAwaiterBehaviour();
    await mySpaceBinding.loadSharedPreferences();
    runApp(const ProviderScope(child: QuizLearningApp._()));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(routerConfigProvider);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp.router(
        builder: (_, child) {
          return AppStartupWidget(
            onLoaded: (_) => Directionality(
              textDirection: ref.watch(languageDirectionProvider),
              child: child!,
            ),
          );
        },
        title: 'Quiz Learning App',
        scaffoldMessengerKey: ref.watch(snackBarProvider).scaffoldKey,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: ref.watch(currentLocalizationProvider),
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        routerConfig: goRouter,
      ),
    );
  }
}
