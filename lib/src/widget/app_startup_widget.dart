import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/features/app_provider/app_startup/app_startup_provider.dart';
import '../core/features/app_provider/app_startup/state/app_startup_state.dart';
import 'loading_widget.dart';

class AppStartupWidget extends ConsumerStatefulWidget {
  const AppStartupWidget({super.key, required this.onLoaded});

  final WidgetBuilder onLoaded;

  @override
  ConsumerState<AppStartupWidget> createState() => _AppStartupWidgetState();
}

class _AppStartupWidgetState extends ConsumerState<AppStartupWidget> {
  final loadingWidget = Scaffold(body: LoadingWidget());

  @override
  Widget build(BuildContext context) {
    final appStartup = ref.watch(appStartupProvider);
    ref.listen<AsyncValue<AppStartupState>>(appStartupProvider, (_, state) {
      if (state.hasValue || state.hasError) FlutterNativeSplash.remove();
    });
    return switch (appStartup) {
      AsyncLoading() => loadingWidget,
      AsyncError(:final isRefreshing) => () {
        if (isRefreshing) return loadingWidget;
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const .symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  const Text(
                    'Oops! Something went wrong while loading your settings.'
                    ' Please try again or restart the app.',
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    child: Text(
                      'Retry',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    onPressed: () {
                      final _ = ref.refresh(appStartupProvider);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }(),
      AsyncValue() => widget.onLoaded(context),
    };
  }
}
